//
//  BasicMath.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 8/30/18.
//  Copyright © 2018 alexrvarela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BasicMath : NSObject

+ (NSInteger)randomInt:(NSInteger)max;

+ (NSInteger)randomIntRange:(NSInteger)max min:(NSInteger)min;

+ (CGFloat)randomFloat:(CGFloat)max;

+ (CGFloat)randomFloatRange:(CGFloat)max min:(CGFloat)min;

+ (CGFloat)toRadians:(CGFloat)degree;

+ (CGFloat)toDegrees:(CGFloat)radian;

//Angle calculation between 2 points
+ (CGFloat)angle:(CGPoint)start
             end:(CGPoint)end;

//Distance calculation between 2 points
+ (CGFloat)length:(CGPoint)start
              end:(CGPoint)end;


+ (CGPoint)arcRotationPoint:(CGFloat)angle
                     radius:(CGFloat)radius;

+ (CGPoint)ellipseRotationPoint:(CGFloat)angle
                        xradius:(CGFloat)xradius
                        yradius:(CGFloat)yradius;

+ (CGFloat)linear:(CGFloat)t
                a:(CGFloat)a
                b:(CGFloat)b;

+ (CGFloat)quad:(CGFloat)t
              a:(CGFloat)a
              b:(CGFloat)b
              c:(CGFloat)c;

+ (CGFloat)quadTangent:(CGFloat)t
                     a:(CGFloat)a
                     b:(CGFloat)b
                     c:(CGFloat)c;

//Cubic interpolation
+ (CGFloat)cubic:(CGFloat)t
               a:(CGFloat)a
               b:(CGFloat)b
               c:(CGFloat)c
               d:(CGFloat)d;

+ (CGFloat)cubicTangent:(CGFloat)t
                      a:(CGFloat)a
                      b:(CGFloat)b
                      c:(CGFloat)c
                      d:(CGFloat)d;

@end
