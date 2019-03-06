//
//  Ease.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/23/19.
//  Copyright © 2019 alexrvarela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ease : NSObject

/**
 * Data type for equations.
 *
 * @param t        Current time (in frames or seconds).
 * @param b        Starting value.
 * @param c        Change needed in value.
 * @param d        Expected easing duration (in frames or seconds).
 * @return        The correct value.
 */
typedef double (^Equation)(double t, double b, double c, double d);

#pragma mark - None

+(Equation)none;

#pragma mark - Quad

+(Equation)inQuad;
+(Equation)outQuad;
+(Equation)inOutQuad;
+(Equation)outInQuad;

#pragma mark - Cubic

+(Equation)inCubic;
+(Equation)outCubic;
+(Equation)inOutCubic;
+(Equation)outInCubic;

#pragma mark - Quart

+(Equation)inQuart;
+(Equation)outQuart;
+(Equation)inOutQuart;
+(Equation)outInQuart;

#pragma mark - Quint

+(Equation)inQuint;
+(Equation)outQuint;
+(Equation)inOutQuint;
+(Equation)outInQuint;

#pragma mark - Sine

+(Equation)inSine;
+(Equation)outSine;
+(Equation)inOutSine;
+(Equation)outInSine;

#pragma mark - Expo

+(Equation)inExpo;
+(Equation)outExpo;
+(Equation)inOutExpo;
+(Equation)outInExpo;

#pragma mark - Circ

+(Equation)inCirc;
+(Equation)outCirc;
+(Equation)inOutCirc;
+(Equation)outInCirc;

#pragma mark - Elastic

+(Equation)inElastic;
+(Equation)outElastic;
+(Equation)inOutElastic;
+(Equation)outInElastic;

#pragma mark - Back

+(Equation)inBack;
+(Equation)outBack;
+(Equation)inOutBack;
+(Equation)outInBack;

#pragma mark - Bounce

+(Equation)inBounce;
+(Equation)outBounce;
+(Equation)inOutBounce;
+(Equation)outInBounce;

@end
