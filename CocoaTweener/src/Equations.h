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

#import <Foundation/Foundation.h>

typedef struct{float f;}floatStruct;

@interface Equations : NSObject

+(floatStruct) easeNone:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInQuad:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutQuad:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutQuad:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInQuad:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInCubic:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutCubic:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutCubic:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInCubic:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInQuart:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutQuart:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutQuart:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInQuart:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInQuint:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutQuint:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutQuint:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInQuint:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInSine:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutSine:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutSine:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInSine:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInExpo:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutExpo:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutExpo:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInExpo:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInCirc:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutCirc:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutCirc:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInCirc:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInElastic:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutElastic:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutElastic:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInElastic:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInBack:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutBack:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutBack:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInBack:(float)t begin:(float)b change:(float)c duration:(float)d;

+(floatStruct) easeInBounce:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutBounce:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeInOutBounce:(float)t begin:(float)b change:(float)c duration:(float)d;
+(floatStruct) easeOutInBounce:(float)t begin:(float)b change:(float)c duration:(float)d;

@end
