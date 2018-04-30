//
//  TweenValues.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweenValues : NSObject

//TODO:use NSNUmber Array

@property (nonatomic) float *valueStart;//malloc
@property (nonatomic) float *valueComplete;//malloc
@property float *originalValueComplete;//malloc

@property (readonly, nonatomic) int size;

-(BOOL)completed;

//TODO:use NSNUmber Array
-(id)initWithStartValue:(float*)valuestart
          valueComplete:(float*)valuecomplete
  originalValueComplete:(float*)originalvaluecomplete
              floatSize:(int)floatSize;


@end
