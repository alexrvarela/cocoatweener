//
//  Equations.h
//  Animation

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

#import "Equations.h"

@implementation Equations

/**
 * Easing equation function for a simple linear tweening, with no easing.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunsequenced"

+(floatStruct)easeNone:(float)t begin:(float)b change:(float)c duration:(float)d
{
    floatStruct v;
    v.f = c * t / d + b;
	return v;
}

/**
 * Easing equation function for a quadratic (t^2) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */

+(floatStruct) easeInQuad:(float)t begin:(float)b change:(float)c duration:(float)d
{
    floatStruct v;
    v.f = c * (t /= d) * t + b;
	return v;
}

/**
 * Easing equation function for a quadratic (t^2) easing out: decelerating to zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutQuad:(float)t begin:(float)b change:(float)c duration:(float)d
{
    floatStruct v;
	v.f = -c *(t/=d)*(t-2) + b;
	return v;
}

/**
 * Easing equation function for a quadratic (t^2) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInOutQuad:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if ((t/=d/2) < 1) v.f = c/2*t*t + b;
    else v.f = -c/2 * ((--t)*(t-2) - 1) + b;
    return v;
}

/**
 * Easing equation function for a quadratic (t^2) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutInQuad:(float)t begin:(float)b change:(float)c duration:(float)d
{
	if (t < d/2) return [self easeOutQuad:t*2 begin:b change:c/2 duration:d];
	else return [self easeInQuad:(t*2)-d begin:b+c/2 change:c/2 duration:d];
}

/**
 * Easing equation function for a cubic (t^3) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInCubic:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = c*(t/=d)*t*t + b;
    return v;
}

/**
 * Easing equation function for a cubic (t^3) easing out: decelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutCubic:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = c*((t=t/d-1)*t*t + 1) + b;
    return v;
}

/**
 * Easing equation function for a cubic (t^3) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInOutCubic:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if ((t/=d/2) < 1) v.f = c/2*t*t*t + b;
	else v.f = c/2*((t-=2)*t*t + 2) + b;
    return v;
}

/**
 * Easing equation function for a cubic (t^3) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutInCubic:(float)t begin:(float)b change:(float)c duration:(float)d{

	if (t < d/2) return [self easeOutCubic:t*2 begin:b change:c/2 duration:d];
	else return [self easeOutCubic:(t*2)-d begin:b+c/2 change:c/2 duration: d];
}

/**
 * Easing equation function for a quartic (t^4) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInQuart:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = c*(t/=d)*t*t*t + b;
    return v;
}

/**
 * Easing equation function for a quartic (t^4) easing out: decelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutQuart:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = -c * ((t=t/d-1)*t*t*t - 1) + b;
    return v;
}

/**
 * Easing equation function for a quartic (t^4) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInOutQuart:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if ((t/=d/2) < 1) v.f = c/2*t*t*t*t + b;
    else v.f = -c/2 * ((t-=2)*t*t*t - 2) + b;
    return v;
}

/**
 * Easing equation function for a quartic (t^4) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutInQuart:(float)t begin:(float)b change:(float)c duration:(float)d{
	if (t < d/2) return [self easeOutQuart:t*2 begin:b change:c/2 duration:d];
	else return [self easeOutQuart:(t*2)-d begin:b+c/2 change:c/2 duration:d];
}

/**
 * Easing equation function for a quintic (t^5) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInQuint:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = c*(t/=d)*t*t*t*t + b;
    return v;
}

/**
 * Easing equation function for a quintic (t^5) easing out: decelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutQuint:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = c*((t=t/d-1)*t*t*t*t + 1) + b;
    return v;
}

/**
 * Easing equation function for a quintic (t^5) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInOutQuint:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if ((t/=d/2) < 1) v.f = c/2*t*t*t*t*t + b;
	else v.f = c/2*((t-=2)*t*t*t*t + 2) + b;
    return v;
}

/**
 * Easing equation function for a quintic (t^5) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutInQuint:(float)t begin:(float)b change:(float)c duration:(float)d{
	if (t < d/2) return [self easeOutQuint:t*2 begin:b change:c/2 duration:d];
	return [self easeInQuint:(t*2)-d begin:b+c/2 change:c/2 duration:d];
}

/**
 * Easing equation function for a sinusoidal (sin(t)) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInSine:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = -c * cos(t/d * (M_PI/2)) + c + b;
    return v;
}

/**
 * Easing equation function for a sinusoidal (sin(t)) easing out: decelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutSine:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = c * sin(t/d * (M_PI/2)) + b;
    return v;
}

/**
 * Easing equation function for a sinusoidal (sin(t)) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInOutSine:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = -c/2 * (cos(M_PI*t/d) - 1) + b;
    return v;
}

/**
 * Easing equation function for a sinusoidal (sin(t)) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutInSine:(float)t begin:(float)b change:(float)c duration:(float)d{
	if (t < d/2) return [self easeOutSine:t*2 begin:b change:c/2 duration:d];
	return [self easeInSine:(t*2)-d begin:b+c/2 change:c/2 duration:d];
}

/**
 * Easing equation function for an exponential (2^t) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInExpo:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = (t==0) ? b : c * pow(2, 10 * (t/d - 1)) + b - c * 0.001;
    return v;
}

/**
 * Easing equation function for an exponential (2^t) easing out: decelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutExpo:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = (t==d) ? b+c : c * 1.001 * (-pow(2, -10 * t/d) + 1) + b;
    return v;
}

/**
 * Easing equation function for an exponential (2^t) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInOutExpo:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if (t==0) {v.f = b; return v;};
	if (t==d) {v.f = b+c; return v;};
	if ((t/=d/2) < 1){ v.f = c/2 * pow(2, 10 * (t - 1)) + b - c * 0.0005; return v;};
    v.f = c/2 * 1.0005 * (-pow(2, -10 * --t) + 2) + b;
    return v;
}

/**
 * Easing equation function for an exponential (2^t) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutInExpo:(float)t begin:(float)b change:(float)c duration:(float)d{
	if (t < d/2) return [self easeOutExpo:t*2 begin:b change:c/2 duration:d];
	return [self easeInExpo:(t*2)-d begin:b+c/2 change:c/2 duration:d];
}

/**
 * Easing equation function for a circular (sqrt(1-t^2)) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInCirc:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = -c * (sqrt(1 - (t/=d)*t) - 1) + b;
    return v;
}

/**
 * Easing equation function for a circular (sqrt(1-t^2)) easing out: decelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutCirc:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	v.f = c * sqrt(1 - (t=t/d-1)*t) + b;
    return v;
}

/**
 * Easing equation function for a circular (sqrt(1-t^2)) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInOutCirc:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if ((t/=d/2) < 1) v.f = -c/2 * (sqrt(1 - t*t) - 1) + b;
	else v.f = c/2 * (sqrt(1 - (t-=2)*t) + 1) + b;
    return v;
}

/**
 * Easing equation function for a circular (sqrt(1-t^2)) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutInCirc:(float)t begin:(float)b change:(float)c duration:(float)d{
	if (t < d/2) return [self easeOutCirc:t*2 begin:b change:c/2 duration:d];
	return [self easeInCirc:(t*2)-d begin:b+c/2  change:c/2 duration:d];
}

/**
 * Easing equation function for an elastic (exponentially decaying sine wave) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @var   a		Amplitude.
 * @var   p		Period.
 * @return		The correct value.
 */
+(floatStruct) easeInElastic:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if (t==0) {v.f = b; return v;}
	if ((t/=d)==1) {v.f = b+c;return v;}
    
	float p = d*.3;
	float s;
	float a = 0;
	if (a < fabs(c)) {
		a = c;
		s = p/4;
	} else {
		s = p/(2*M_PI) * asin (c/a);
	}
	v.f = -(a*pow(2,10*(t-=1)) * sin( (t*d-s)*(2*M_PI)/p )) + b;
    return v;
}

/**
 * Easing equation function for an elastic (exponentially decaying sine wave) easing out: decelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @var a		Amplitude.
 * @var p		Period.
 * @return		The correct value.
 */
+(floatStruct) easeOutElastic:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if (t==0) {v.f = b; return v;}
	if ((t/=d)==1) {v.f = b+c; return v;}
	float p = d*.3;
	float s;
	float a = 0;
	if (a < fabs(c)) {
		a = c;
		s = p/4;
	} else {
		s = p/(2*M_PI) * asin (c/a);
	}
	v.f = (a*pow(2,-10*t) * sin( (t*d-s)*(2*M_PI)/p ) + c + b);
    return v;
}

/**
 * Easing equation function for an elastic (exponentially decaying sine wave) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @var a		Amplitude.
 * @var p		Period.
 * @return		The correct value.
 */
+(floatStruct) easeInOutElastic:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if (t==0) {v.f = b; return v;}
	if ((t/=d/2)==2) {v.f = b+c; return v;}
	float p = d*(.3*1.5);
	float s;
	float a = 0 ;
	if (a < fabs(c)) {
		a = c;
		s = p/4;
	} else {
		s = p/(2*M_PI) * asin (c/a);
	}
	if (t < 1) v.f = -.5*(a*pow(2,10*(t-=1)) * sin( (t*d-s)*(2*M_PI)/p )) + b;
	else v.f = a*pow(2,-10*(t-=1)) * sin( (t*d-s)*(2*M_PI)/p )*.5 + c + b;
    return v;
}

/**
 * Easing equation function for an elastic (exponentially decaying sine wave) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @var a		Amplitude.
 * @var p		Period.
 * @return		The correct value.
 */
+(floatStruct) easeOutInElastic:(float)t begin:(float)b change:(float)c duration:(float)d{
	if (t < d/2) return [self easeOutElastic:t*2 begin:b change:c/2 duration:d];
	return [self easeInElastic:(t*2)-d begin:b+c/2 change:c/2 duration:d];
}

/**
 * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @var s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
 * @return		The correct value.
 */
+(floatStruct) easeInBack:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	float s = 1.70158;
	v.f = c*(t/=d)*t*((s+1)*t - s) + b;
    return v;
}

/**
 * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out: decelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @var s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
 * @return		The correct value.
 */
+(floatStruct) easeOutBack:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	float s = 1.70158;
	v.f = c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
    return v;
}

/**
 * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @var s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
 * @return		The correct value.
 */
+(floatStruct) easeInOutBack:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	float s = 1.70158;
    t /= d;
	if ((t/2) < 1) v.f = c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
	else v.f = c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
    return v;
}

/**
 * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @var s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
 * @return		The correct value.
 */
+(floatStruct) easeOutInBack:(float)t begin:(float)b change:(float)c duration:(float)d{
	if (t < d/2) return [self easeOutBack:t*2 begin:b change:c/2 duration:d];
	return [self easeInBack:(t*2)-d begin:b+c/2 change:c/2 duration:d];
}

/**
 * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in: accelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInBounce:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
    floatStruct r =[self easeOutBounce:d-t begin:0 change:c duration:d];
    v.f = c - r.f + b;
    return v;
}

/**
 * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing out: decelerating from zero velocity.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutBounce:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
	if ((t/=d) < (1/2.75)) {
		v.f = c*(7.5625*t*t) + b; return v;
	} else if (t < (2/2.75)) {
		v.f = c*(7.5625*(t-=(1.5/2.75))*t + .75) + b; return v;
	} else if (t < (2.5/2.75)) {
		v.f = c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b; return v;
	} else {
        v.f = c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b; return v;
	}
    //return v;
}

/**
 * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in/out: acceleration until halfway, then deceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeInOutBounce:(float)t begin:(float)b change:(float)c duration:(float)d{
    floatStruct v;
    floatStruct r;
	if (t < d/2){ r = [self easeInBounce:t*2 begin:0 change:c duration:d]; v.f = r.f * .5 + b; return v;}
	else{ r = [self easeOutBounce:t*2-d begin:0 change:c duration:d]; v.f = r.f * .5 + c*.5 + b; return v;}
}

/**
 * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing out/in: deceleration until halfway, then acceleration.
 *
 * @param t		Current time (in frames or seconds).
 * @param b		Starting value.
 * @param c		Change needed in value.
 * @param d		Expected easing duration (in frames or seconds).
 * @return		The correct value.
 */
+(floatStruct) easeOutInBounce:(float)t begin:(float)b change:(float)c duration:(float)d{
	if (t < d/2) return [self easeOutBounce:t*2 begin:b change:c/2 duration:d];
	return [self easeInBounce:(t*2)-d begin:b+c/2 change:c/2 duration:d];
}

#pragma clang diagnostic pop

@end
