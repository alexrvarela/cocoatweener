//
//  OVCUtils.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/2/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVCUtils : NSObject

#pragma mark - Object Type Utils
+(NSString*)getTypeString:(id)value;
+(int)getFloatSize:(id)value;
+(float*)getFloats:(id)value;

#pragma mark - Invocation
+(void)invokeMethod:(NSInvocation*)invocation withParams:(NSArray*)params;
+(NSInvocation*)buildInvocation:(NSString*)method fromTarget:(id)target;
+(NSInvocation*) buildInvocation:(NSString*)transition fromClass:(NSString*)classname;

#pragma mark - Object inspection
-(void)log:(id)object;

@end
