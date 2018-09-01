//
//  Tween.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweenControl.h"
#import "Tween.h"
#import "KVCUtils.h"
#import "Equations.h"
#import "CocoaTweener.h"

@implementation TweenControl

#pragma mark - Constructor
-(id)init:(Tween*)tween timeStart:(float)timeStart// timeComplete:(float)timeComplete
{
    //TODO: validate TweenObject, target  and keys
    if (tween.target == nil){printf("Error, tween target must dont be nil\n"); return nil;}
    if (tween.keys == nil){printf("Error, tween keys must dont be nil\n"); return nil;}
    
    if ([super init])
    {
        self.tween = tween;
        self.timeStart = timeStart;
        self.isTimelineTween = NO;
        [self resetState];//todo:enum states
        
//        printf("TweenControl init completed : %s\n", self.completed ? "true" : "false");
    }
    
    return self;
}

-(BOOL)completed
{
    
    //if (self.state != kTweenStateOver)return NO;
    BOOL completed = YES;
    
    for (TweenValues* v in (NSArray<TweenValues*>*) [self.properties allValues])
        
        if ( ![v completed] )
        {
            completed = NO; break;    
        }

    return completed;
}

-(void)setTween:(Tween*)tween
{
    _tween = tween;
    [self setupController];
}

-(void)setupController
{
    //set properties
    [self setKeys:self.tween.keys];
    
    //build invocation
    NSInvocation *invocation = nil;
    invocation = [KVCUtils buildInvocation:easeToString(self.tween.ease) fromClass:@"Equations"];
    if(invocation == nil)printf("Warning : invalid transition ease\n");
    self.invocation = invocation;
}

-(void)setTimeStart:(float)timeStart
{
    _timeStart = timeStart;
    [self updateTimeComplete];
}

-(void)updateTimeComplete
{
    self.timeComplete = self.timeStart + (self.tween.duration / [CocoaTweener getTimeScale]);
}

-(void)resetState
{
    //printf("Tween control, reset state\n");
    self.state = kTweenStateInitial;
    self.timePaused = 0;
}

-(void)setState:(kTweenState)state
{
    _lastState = _state;
    _state = state;
}

//TODO: rename to setProperties:
#pragma mark - Set KVC properties
-(void)setKeys:(NSDictionary*)keys
{
    if (!self.tween.target)return;
    
    NSMutableDictionary *validProperties = [[NSMutableDictionary alloc] init];
    
    // Verifies whether the properties exist or not, for warning messages
    for (id key in keys)
    {
        if ([self.tween.target valueForKey:key] == nil)
        {
            NSLog(@"Warning, the property %@ doesn't seem to be a normal object property of %@.", key ,self.tween.target);
        }else
        {
            //sure filter kind of values
            NSString * typeString = [KVCUtils getTypeString:[self.tween.target valueForKey:key]];
            
            //forces doubles to float (ARC 64 bit)
            if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(double)]])
                typeString = [NSString stringWithUTF8String:@encode(float)];
            
            NSString * propertyTypeString = [KVCUtils getTypeString:[keys valueForKey:key]];
            
            BOOL validProperty = NO;
            
            if ([typeString isEqualToString:propertyTypeString])
            {
                if (
                    [typeString isEqualToString:[NSString stringWithUTF8String:@encode(float)]]
                    || [typeString isEqualToString:[NSString stringWithUTF8String:@encode(int)]]
                    || [typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGPoint)]]
                    || [typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGSize)]]
                    || [typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGRect)]]
                    || [typeString isEqualToString:[NSString stringWithUTF8String:@encode(UIColor)]]
                    )
                {
                    validProperty = YES;
                }else
                {
                    //printf("Warning, the property %s, type is not supported.", ((NSString*)key).UTF8String);
                }
                
                if(validProperty)
                {
                    if ([typeString isEqualToString:[NSString stringWithUTF8String:@encode(int)]])
                    {
                        printf("integer added : %i\n", (int)[[keys objectForKey:key] intValue]);
                        [validProperties setObject:[NSNumber numberWithInt:(int)[[keys objectForKey:key] intValue]] forKey:key];//convert to integer
                    }
                    else
                        [validProperties setObject:[keys objectForKey:key] forKey:key];
                }
                else
                    NSLog(@"The property %@ not supported kind type :  %@ use special property way." ,key ,typeString);
            }
            else
            {
                NSLog(@"Error The property : %@ : type : %@ doesn't same kind value of param :  %@ or a registered special property. for target : %@", key, typeString ,propertyTypeString, self.tween.target);
            }
        }
    }
    
    NSMutableDictionary *nProperties = [[NSMutableDictionary alloc] init];
    
    for (id istr in validProperties)
    {
        int sizeOfValue = [KVCUtils getFloatSize:[validProperties objectForKey:istr]];
        float *startValue = [KVCUtils getFloats:[self.tween.target valueForKey:istr]];
        float *completeValue = [KVCUtils getFloats:[validProperties objectForKey:istr]];
        float *originalCompleteValue = [KVCUtils getFloats:[validProperties objectForKey:istr]];
        
        TweenValues* values = [[TweenValues alloc] initWithStartValue:startValue
                                                        valueComplete:completeValue
                                                originalValueComplete:originalCompleteValue
                                                            floatSize:sizeOfValue];
        
        [nProperties setObject:values forKey:istr];
    }
    
    self.properties = nProperties;
}

-(void)dealloc
{
    //printf("controller released\n");
}

@end
