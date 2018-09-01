//
//  BasicMath.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 8/30/18.
//  Copyright © 2018 alexrvarela. All rights reserved.
//

#import "BasicMath.h"

@implementation BasicMath

#define ARC4RANDOM_MAX 0x100000000

+ (NSInteger)randomInt:(NSInteger)max
{
    return (NSInteger)round(rand() % (NSInteger)max);
}

+ (NSInteger)randomIntRange:(NSInteger)max min:(NSInteger)min
{
    return [self randomInt:(max - min) + min];
}

+ (CGFloat)randomFloat:(CGFloat)max
{
    return ((CGFloat)arc4random() / ARC4RANDOM_MAX) * max;
}

+ (CGFloat)randomFloatRange:(CGFloat)max min:(CGFloat)min
{
    return [self randomFloat:((max - min)) + min];
}

+ (CGFloat)toRadians:(CGFloat)degree
{
    return degree * M_PI / 180.0;
}

+ (CGFloat)toDegrees:(CGFloat)radian
{
    return radian * 180.0 / M_PI ;
}

//Angle between 2 points
+ (CGFloat)angle:(CGPoint)start
             end:(CGPoint)end
{
    return atan2(end.y - start.y,  end.x - start.x);
}

//Distance between 2 points
+ (CGFloat)length:(CGPoint)start
              end:(CGPoint)end
{
    float a = start.x - end.x;
    float b = start.y - end.y;
    return sqrtf(a * a + b * b);
}

+ (CGPoint)arcRotationPoint:(CGFloat)angle radius:(CGFloat)radius
{
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    
    return CGPointMake(x, y);
}

+ (CGPoint)ellipseRotationPoint:(CGFloat)angle xradius:(CGFloat)xradius yradius:(CGFloat)yradius
{
    float x = cos(angle) * xradius;
    float y = sin(angle) * yradius;
    
    return CGPointMake(x, y);
}

+ (CGFloat)quadTangent:(CGFloat)t
                     a:(CGFloat)a
                     b:(CGFloat)b
                     c:(CGFloat)c
{
    return (2 * (1 - t) * (b - a)) + (2 * t * (c - b));
}

+ (CGFloat)cubicTangent:(CGFloat)t
                      a:(CGFloat)a
                      b:(CGFloat)b
                      c:(CGFloat)c
                      d:(CGFloat)d
{
    return (3 * pow(1 - t, 2) * (b - a)) +
    (6 * (1 - t) * t * (c - b)) +
    (3 * pow(t, 2) * (d - c));
}

//Linear interpolation
+ (CGFloat)linear:(CGFloat)t
                a:(CGFloat)a
                b:(CGFloat)b
{
    return a + ( b - a) * t;
}

//Quad interpolation
+ (CGFloat)quad:(CGFloat)t
              a:(CGFloat)a
              b:(CGFloat)b
              c:(CGFloat)c
{
    
    return (pow(1 - t, 2) * a)
    + (2 * (1 - t) * t * b)
    + (pow(t, 2) * c);
}

//Cubic interpolation
+ (CGFloat)cubic:(CGFloat)t
               a:(CGFloat)a
               b:(CGFloat)b
               c:(CGFloat)c
               d:(CGFloat)d
{
    return (pow(1 - t, 3) * a) +
    (3 * pow(1 - t, 2) * t * b) +
    (3 * (1 - t) * pow(t, 2) * c) +
    (pow(t, 3) * d);
}

@end

