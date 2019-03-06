//
//  Ease.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/23/19.
//  Copyright © 2019 alexrvarela. All rights reserved.
//

/*
 Disclaimer for Robert Penner's Easing Equations license:
 
 TERMS OF USE - EASING EQUATIONS
 
 Open source under the BSD License.
 
 Copyright © 2001 Robert Penner
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

// ==================================================================================================================================
// TWEENING EQUATIONS functions -----------------------------------------------------------------------------------------------------
// (the original equations are Robert Penner's work as mentioned on the disclaimer)

#import "Ease.h"

@implementation Ease

#pragma mark - None

/// Easing equation function for a simple linear tweening, with no easing.
static Equation none = ^(double t, double b, double c, double d){
    return c * t / d + b;
};

+(Equation)none{return none;};

#pragma mark - Quad

/// Easing equation function for a quadratic (t^2) easing in: accelerating from zero velocity.
/// @var i       Interpolation.
static Equation inQuad = ^(double t, double b, double c, double d){
    double i = t / d;
    return c * i * i + b;
};
+(Equation)inQuad{return inQuad;};

/// Easing equation function for a quadratic (t^2) easing out: decelerating to zero velocity.
/// @var i       Interpolation.
static Equation outQuad = ^(double t, double b, double c, double d){
    double i = t / d;
    return (-c) * i * ( i - 2) + b;
};
+(Equation)outQuad{return outQuad;};

/// Easing equation function for a quadratic (t^2) easing in/out: acceleration until halfway, then deceleration.
/// @var i       Interpolation.
static Equation inOutQuad = ^(double t, double b, double c, double d){
    if (t < d/2) { return Ease.inQuad(t*2, b, c/2, d);};
    return Ease.outQuad((t*2)-d, b+c/2, c/2, d);
};
+(Equation)inOutQuad{return inOutQuad;};

/// Easing equation function for a quadratic (t^2) easing out/in: deceleration until halfway, then acceleration.
static Equation outInQuad = ^(double t, double b, double c, double d){
    if (t < d/2) { return Ease.outQuad(t*2, b, c/2, d);};
    return Ease.inQuad((t*2)-d, b+c/2, c/2, d);
};
+(Equation)outInQuad{return outInQuad;};

#pragma mark - Cubic

/// Easing equation function for a cubic (t^3) easing in: accelerating from zero velocity.
/// @var i       Interpolation.
static Equation inCubic = ^(double t, double b, double c, double d){
    double i = t/d;
    return c*i*i*i+b;
};
+(Equation)inCubic{return inCubic;};

/// Easing equation function for a cubic (t^3) easing out: decelerating from zero velocity.
/// @var i       Interpolation.
static Equation outCubic = ^(double t, double b, double c, double d){
    double i = t/d-1;
    return c*(i*i*i+1)+b;
};
+(Equation)outCubic{return outCubic;};

/// Easing equation function for a cubic (t^3) easing in/out: acceleration until halfway, then deceleration.
/// @var i       Interpolation.
static Equation inOutCubic = ^(double t, double b, double c, double d){
    double i = t/(d/2);
    if (i < 1) return c/2*i*i*i+b;
    i=i-2;
    return c/2*(i*i*i+2)+b;
};
+(Equation)inOutCubic{return inOutCubic;};

/// Easing equation function for a cubic (t^3) easing out/in: deceleration until halfway, then acceleration.
static Equation outInCubic = ^(double t, double b, double c, double d){
    if (t < d/2) return Ease.outCubic(t*2,b,c/2,d);
    else return Ease.inCubic((t*2)-d,b+c/2,c/2,d);
};
+(Equation)outInCubic{return outInCubic;};

#pragma mark - Quart

/// Easing equation function for a quartic (t^4) easing in: accelerating from zero velocity.
/// @var i       Interpolation.
static Equation inQuart = ^(double t, double b, double c, double d){
    double i = (t/=d);
    return c*i*i*i*i+b;
};
+(Equation)inQuart{return inQuart;};

/// Easing equation function for a quartic (t^4) easing out: decelerating from zero velocity.
/// @var i       Interpolation.
static Equation outQuart = ^(double t, double b, double c, double d){
    double i = t/d-1;
    return (-c)*(i*i*i*i-1)+b;
};
+(Equation)outQuart{return outQuart;};

/// Easing equation function for a quartic (t^4) easing in/out: acceleration until halfway, then deceleration.
static Equation inOutQuart = ^(double t, double b, double c, double d){
    double i = t/(d/2);
    if (i < 1) return c/2*i*i*i*i + b;
    i=i-2;
    return (-c)/2*(i*i*i*i-2)+b;
};
+(Equation)inOutQuart{return inOutQuart;};

/// Easing equation function for a quartic (t^4) easing out/in: deceleration until halfway, then acceleration.
static Equation outInQuart = ^(double t, double b, double c, double d){
    if (t < d/2) return Ease.outQuart(t*2, b, c/2, d);
    return Ease.inQuart((t*2)-d, b+c/2, c/2, d);
};
+(Equation)outInQuart{return outInQuart;};

#pragma mark - Quint

/// Easing equation function for a quintic (t^5) easing in: accelerating from zero velocity.
/// @var i       Interpolation.
static Equation inQuint = ^(double t, double b, double c, double d){
    double i = t/d;
    return c*i*i*i*i*i+b;
};
+(Equation)inQuint{return inQuint;};

/// Easing equation function for a quintic (t^5) easing out: decelerating from zero velocity.
/// @var i       Interpolation.
static Equation outQuint = ^(double t, double b, double c, double d){
    double i = t/d-1;
    return c*(i*i*i*i*i+1)+b;
};
+(Equation)outQuint{return outQuint;};

/// Easing equation function for a quintic (t^5) easing in/out: acceleration until halfway, then deceleration.
/// @var i       Interpolation.
static Equation inOutQuint = ^(double t, double b, double c, double d){
    double i = t/(d/2);
    if (i < 1) return c/2*i*i*i*i*i+b;
    i = i-2;
    return c/2*(i*i*i*i*i+2)+b;
};
+(Equation)inOutQuint{return inOutQuint;};

/// Easing equation function for a quintic (t^5) easing out/in: deceleration until halfway, then acceleration.
static Equation outInQuint = ^(double t, double b, double c, double d){
    if (t < d/2) return Ease.outQuint (t*2, b, c/2, d);
    return Ease.inQuint((t*2)-d, b+c/2, c/2, d);
};
+(Equation)outInQuint{return outInQuint;};

#pragma mark - Sine

/// Easing equation function for a sinusoidal (sin(t)) easing in: accelerating from zero velocity.
static Equation inSine = ^(double t, double b, double c, double d){
    return (-c)*cos(t/d*(M_PI/2))+c+b;
};
+(Equation)inSine{return inSine;};

/// Easing equation function for a sinusoidal (sin(t)) easing out: decelerating from zero velocity.
static Equation outSine = ^(double t, double b, double c, double d){
    return c*sin(t/d * (M_PI/2))+b;
};
+(Equation)outSine{return outSine;};

/// Easing equation function for a sinusoidal (sin(t)) easing in/out: acceleration until halfway, then deceleration.
static Equation inOutSine = ^(double t, double b, double c, double d){
    return (-c)/2*(cos(M_PI*t/d)-1)+b;
};
+(Equation)inOutSine{return inOutSine;};

/// Easing equation function for a sinusoidal (sin(t)) easing out/in: deceleration until halfway, then acceleration.
static Equation outInSine = ^(double t, double b, double c, double d){
    if (t < d/2) return Ease.outSine(t*2, b, c/2, d);
    return Ease.inSine((t*2)-d, b+c/2, c/2, d);
};
+(Equation)outInSine{return outInSine;};

#pragma mark - Expo

/// Easing equation function for an exponential (2^t) easing in: accelerating from zero velocity.
static Equation inExpo = ^(double t, double b, double c, double d){
    return (t==0) ? b : c * pow(2, 10 * (t/d - 1)) + b - c * 0.001;
};
+(Equation)inExpo{return inExpo;};

/// Easing equation function for an exponential (2^t) easing out: decelerating from zero velocity.
static Equation outExpo = ^(double t, double b, double c, double d){
    return (t==d) ? b+c : c * 1.001 * (-pow(2, -10 * t/d) + 1) + b;
};
+(Equation)outExpo{return outExpo;};

/// Easing equation function for an exponential (2^t) easing in/out: acceleration until halfway, then deceleration.
/// @var i       Interpolation.
static Equation inOutExpo = ^(double t, double b, double c, double d){
    if (t==0) return b;
    if (t==d) return b+c;
    double i = t/(d/2);
    if (i < 1) return c/2 * pow(2, 10 * (i - 1)) + b - c * 0.0005;
    i = i-1;
    return c/2 * 1.0005 * (-pow(2, -10 * i) + 2) + b;
};
+(Equation)inOutExpo{return inOutExpo;};

/// Easing equation function for an exponential (2^t) easing out/in: deceleration until halfway, then acceleration.
static Equation outInExpo = ^(double t, double b, double c, double d){
    if (t < d/2) return Ease.outExpo(t*2, b, c/2, d);
    return Ease.inExpo((t*2)-d, b+c/2, c/2, d);
};
+(Equation)outInExpo{return outInExpo;};

#pragma mark - Circ

/// Easing equation function for a circular (sqrt(1-t^2)) easing in: accelerating from zero velocity.
/// @var i       Interpolation.
static Equation inCirc = ^(double t, double b, double c, double d){
    double i = t/d;
    return (-c)*(sqrt(1-i*i)-1)+b;
};
+(Equation)inCirc{return inCirc;};

/// Easing equation function for a circular (sqrt(1-t^2)) easing out: decelerating from zero velocity.
/// @var i      Interpolation.
static Equation outCirc = ^(double t, double b, double c, double d){
    double i = t/d-1;
    return c*sqrt(1-i*i)+b;
};
+(Equation)outCirc{return outCirc;};

/// Easing equation function for a circular (sqrt(1-t^2)) easing in/out: acceleration until halfway, then deceleration.
/// @var i      Interpolation.
static Equation inOutCirc = ^(double t, double b, double c, double d){
    double i = t/(d/2);
    if (i < 1) return -c/2*(sqrt(1-i*i)-1)+b;
    i = i-2;
    return c/2*(sqrt(1-i*i)+1)+b;
};
+(Equation)inOutCirc{return inOutCirc;};

/// Easing equation function for a circular (sqrt(1-t^2)) easing out/in: deceleration until halfway, then acceleration.
static Equation outInCirc = ^(double t, double b, double c, double d){
    if (t < d/2) return Ease.outCirc (t*2, b, c/2, d);
    return Ease.inCirc((t*2)-d, b+c/2, c/2, d);
};
+(Equation)outInCirc{return outInCirc;};

#pragma mark - Elastic

/// Easing equation function for an elastic (exponentially decaying sine wave) easing in: accelerating from zero velocity.
/// @var i      Interpolation.
/// @var a		Amplitude.
/// @var p		Period.
static Equation inElastic = ^(double t, double b, double c, double d){
    if (t==0) {return b;}
    double i = t/d;
    if (i==1) {return b+c;}
    float p = d*.3;
    float s;
    float a = 0;
    if (a < fabs(c)) {
        a = c;
        s = p/4;
    } else {
        s = p/(2*M_PI) * asin (c/a);
    }
    i = i-1;
    return -(a*pow(2,10*i)*sin((i*d-s)*(2*M_PI)/p))+b;
};
+(Equation)inElastic{return inElastic;};

/// Easing equation function for an elastic (exponentially decaying sine wave) easing out: decelerating from zero velocity.
/// @var i      Interpolation.
/// @var a        Amplitude.
/// @var p        Period.
static Equation outElastic = ^(double t, double b, double c, double d){
    if (t==0) {return b;}
    double i = t/d;
    if (i==1) {return b+c;}
    double p = d*.3;
    double s;
    double a = 0;
    if (a < fabs(c)) {
        a = c;
        s = p/4;
    } else {
        s = p/(2*M_PI) * asin (c/a);
    }
    return (a*pow(2,-10*i)*sin((i*d-s)*(2*M_PI)/p)+c+b);
};
+(Equation)outElastic{return outElastic;};

/// Easing equation function for an elastic (exponentially decaying sine wave) easing in/out: acceleration until halfway, then deceleration.
/// @var i      Interpolation.
/// @var a      Amplitude.
/// @var p      Period.
static Equation inOutElastic = ^(double t, double b, double c, double d){
    if (t==0) {return b;}
    double i = t/(d/2);
    if (i==2) {return b+c;}
    double p = d*(0.3*1.5);
    double s;
    double a = 0;
    if (a < fabs(c)){
        a = c;
        s = p/4;
    } else {
        s = p/(2*M_PI)*asin(c/a);
    }
    if (i < 1)
    {
        i = i-1;
        return -.5*(a*pow(2,10*i)*sin((i*d-s)*(2*M_PI)/p))+b;
    }
    else
    {
        i = i-1;
        return a*pow(2,-10*i)*sin((i*d-s)*(2*M_PI)/p)*.5+c+b;
    }
};
+(Equation)inOutElastic{return inOutElastic;};

/// Easing equation function for an elastic (exponentially decaying sine wave) easing out/in: deceleration until halfway, then acceleration.
static Equation outInElastic = ^(double t, double b, double c, double d){
    if (t < d/2) return Ease.outElastic(t*2, b, c/2, d);
    return Ease.inElastic((t*2)-d, b+c/2, c/2, d);
};
+(Equation)outInElastic{return outInElastic;};

#pragma mark - Back
/// Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in: accelerating from zero velocity.
/// @var i      Interpolation.
/// @var s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
static Equation inBack = ^(double t, double b, double c, double d){
    double i = t/d;
    double s = 1.70158;
    return c*i*i*((s+1)*i-s)+b;
};
+(Equation)inBack{return inBack;};

/// Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out: decelerating from zero velocity.
/// @var i      Interpolation.
/// @var s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
static Equation outBack = ^(double t, double b, double c, double d){
    double i = t/d-1;
    double s = 1.70158;
    return c*(i*i*((s+1)*i+s)+1)+b;
};
+(Equation)outBack{return outBack;};

/// Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in/out: acceleration until halfway, then deceleration.
/// @var i      Interpolation.
/// @var s        Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
static Equation inOutBack = ^(double t, double b, double c, double d){
    double i = t/(d/2);
    double s = 1.70158 * 1.525;
    if (i < 1) return c/2*(i*i*((s+1)*i-s))+b;
    i = i-2;
    return c/2*(i*i*((s+1)*i+s)+2)+b;
};
+(Equation)inOutBack{return inOutBack;};

/// Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out/in: deceleration until halfway, then acceleration.
static Equation outInBack = ^(double t, double b, double c, double d){
    if (t < d/2) return Ease.outBack(t*2, b, c/2, d);
    return Ease.inBack((t*2)-d, b+c/2, c/2, d);
};
+(Equation)outInBack{return outInBack;};

#pragma mark - Bounce
/// Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in: accelerating from zero velocity.
static Equation inBounce = ^(double t, double b, double c, double d){
    return c - Ease.outBounce(d-t, 0, c, d) + b;
};
+(Equation)inBounce{return inBounce;};

/// Easing equation function for a bounce (exponentially decaying parabolic bounce) easing out: decelerating from zero velocity.
/// @var i      Interpolation.
static Equation outBounce = ^(double t, double b, double c, double d){
    double i = t/d;
    
    if (i < (1/2.75)) {
        return c*(7.5625*i*i)+b;
    } else if (i < (2/2.75)) {
        i = i-(1.5/2.75);
        return c*(7.5625*i*i+0.75)+b;
    } else if (i < (2.5/2.75)) {
        i = i-(2.25/2.75);
        return c*(7.5625*i*i+0.9375)+b;
    } else {
        i = i-(2.625/2.75);
        return c*(7.5625*i*i+0.984375)+b;
    }
};
+(Equation)outBounce{return outBounce;};

/// Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in/out: acceleration until halfway, then deceleration.
static Equation inOutBounce = ^(double t, double b, double c, double d){
    if (t < d/2) return Ease.inBounce(t*2, 0.0, c, d) * 0.5 + b;
    else return Ease.outBounce(t*2-d, 0.0, c, d) * 0.5 + c*0.5 + b;
};
+(Equation)inOutBounce{return inOutBounce;};

/// Easing equation function for a bounce (exponentially decaying parabolic bounce) easing out/in: deceleration until halfway, then acceleration.
static Equation outInBounce = ^(double t, double b, double c, double d){
			if (t < d/2) return Ease.outBounce (t*2, b, c/2, d);
			return Ease.inBounce((t*2)-d, b+c/2, c/2, d);
};
+(Equation)outInBounce{return outInBounce;};

@end
