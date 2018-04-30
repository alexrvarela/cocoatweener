//
//  OVCUtils.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/2/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "KVCUtils.h"
#import <UIKit/UIKit.h>
#import "Equations.h"
#import <objc/runtime.h>

@implementation KVCUtils

#pragma mark - Object Type Utils
+(NSString*)getTypeString:(id)value
{
    NSString * typeString;//nil by default
    
    //Inspect Key Value Coding (KVC) @properties
    if([value isKindOfClass:[NSValue class]] || [value isKindOfClass:[NSNumber class]])
    {
        //CGRect, CGSisze, CGPoint, double, float, int @properties
        if ([value respondsToSelector:@selector(objCType)])
        {
            const char * type = [value objCType];
            typeString = [NSString stringWithUTF8String:type];
        }
    }
    else if([value isKindOfClass:[UIColor class]])
    {
        //else UIcolor only
        const char * type  = @encode(UIColor);
        typeString = [NSString stringWithUTF8String:type];
    }
    
    return typeString;
}

+(int)getFloatSize:(id)value
{
    NSString * typeString = [self getTypeString:value];
    int size = 0;
    
    //TODO support mote types
    if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(float)]]){size = 1;}
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGFloat)]]){size = 1;}
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(double)]]){size = 1;}
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(int)]]){size = 1;}
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(NSInteger)]]){size = 1;}
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGPoint)]]){size = 2;}
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGSize)]]){size = 2;}
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGRect)]]){size = 4;}
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(UIColor)]]){size = 4;}
    
    return size;
}

+(float*)getFloats:(id)value
{
    NSString * typeString = [self getTypeString:value];
    
    int sizeOfValue = [self getFloatSize:value];
    float* floats = malloc(sizeof(float) * (sizeOfValue));//TODO: free ?
    
    if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(float)]])
    {
        floats[0] = [value floatValue];
    }
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(double)]])
    {
        floats[0] = (float)[value doubleValue];
    }
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(int)]])
    {
        floats[0] = (float)[value intValue];
    }
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGPoint)]])
    {
        CGPoint point = [value CGPointValue];
        
        floats[0] = point.x;
        floats[1] = point.y;
    }
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGSize)]])
    {
        CGSize size = [value CGSizeValue];
        
        floats[0] = size.width;
        floats[1] = size.height;
    }
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGRect)]])
    {
        CGRect rect = [value CGRectValue];
        
        floats[0] = rect.origin.x;
        floats[1] = rect.origin.y;
        floats[2] = rect.size.width;
        floats[3] = rect.size.height;
    }
    else if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(UIColor)]])
    {
        CGFloat* c = (CGFloat*) CGColorGetComponents( ((UIColor*)value).CGColor );
        double a = CGColorGetAlpha( ((UIColor*)value).CGColor );
        
        floats[0] = (float)c[0];
        floats[1] = (float)c[1];
        floats[2] = (float)c[2];
        floats[3] = (float)a;
    }
    
    return floats;
}

#pragma mark - Invocation
+(void)invokeMethod:(NSInvocation*)invocation withParams:(NSArray*)params
{
    for (int indexParams = 0; indexParams < [params count]; indexParams++)
    {
        NSObject* parameter = [params objectAtIndex:indexParams];
        [invocation setArgument:&parameter atIndex:2 + indexParams];
    }
    
    [invocation retainArguments];
    [invocation invoke];
}

+(NSInvocation*)buildInvocation:(NSString*)transition fromClass:(NSString*)classname
{
    NSString* method = [transition stringByAppendingString:@":begin:change:duration:"];
    Class class = [NSClassFromString(classname) class];
    
    NSInvocation * invocation = [self buildInvocation:method fromTarget:class];
    
    return invocation;
}

+(NSInvocation*)buildInvocation:(NSString*)method fromTarget:(id)target
{
    NSInvocation * invocation = nil;
    SEL selector = NSSelectorFromString(method);
    
    if ([target respondsToSelector:selector])
    {
        NSMethodSignature *signature = nil;
        signature = [target methodSignatureForSelector:selector];
        
        if(signature != nil)
        {
            invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:target];
            [invocation setSelector:selector];
            
        }else
        {
            NSLog(@"Failed building signature : %@", signature);
        }
    }
    
    if(invocation == nil)NSLog(@"Error : invalid invocation");
    
    return invocation;
}


#pragma mark - Object inspection
-(void)log:(id)object
{
    unsigned int count;
    objc_property_t* props = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = props[i];
        const char * name = property_getName(property);
        printf("name : %s\n", name);

        const char * type = property_getAttributes(property);
        printf("type : %s\n", type);
        
        NSString * typeString = [NSString stringWithUTF8String:type];
        NSArray * attributes = [typeString componentsSeparatedByString:@","];
        NSString * typeAttribute = [attributes objectAtIndex:0];
        NSString * propertyType = [typeAttribute substringFromIndex:1];
        
        const char * rawPropertyType = [propertyType UTF8String];
        
        printf("raw type : %s\n", rawPropertyType);

        if ([typeAttribute hasPrefix:@"T@"])
        {
            printf("type attribute has prefix\n");
            NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];
            
            Class typeClass = NSClassFromString(typeClassName);
            
            if (typeClass != nil)
            {
                printf("class : %s\n", NSStringFromClass(typeClass).UTF8String);
            }
        }
        
        printf("\n");
    }
    
    free(props);
}

@end
