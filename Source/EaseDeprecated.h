//
//  Ease.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/2/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#ifndef Ease_h
#define Ease_h

//TODO:define as mutable array to support custom eases
#define EASE_STRINGS @[@"easeNone",@"easeInQuad",@"easeOutQuad",@"easeInOutQuad",@"easeOutInQuad",@"easeInCubic", @"easeOutCubic",@"easeInOutCubic",@"easeOutInCubic",@"easeInQuart",@"easeOutQuart",@"easeInOutQuart",@"easeOutInQuart",@"easeInQuint",@"easeOutQuint",@"easeInOutQuint",@"easeOutInQuint",@"easeInSine",@"easeOutSine",@"easeInOutSine",@"easeOutInSine",@"easeInExpo",@"easeOutExpo",@"easeInOutExpo",@"easeOutInExpo",@"easeInCirc",@"easeOutCirc",@"easeInOutCirc",@"easeOutInCirc",@"easeInElastic",@"easeOutElastic",@"easeInOutElastic",@"easeOutInElastic",@"easeInBack",@"easeOutBack",@"easeInOutBack",@"easeOutInBack",@"easeInBounce",@"easeOutBounce",@"easeInOutBounce",@"easeOutInBounce"]

//TODO:support and register custom esaes
typedef enum
{
    Ease.none,
    Ease.inQuad,
    Ease.outQuad,
    Ease.inOutQuad,
    Ease.outInQuad,
    Ease.inCubic,
    Ease.outCubic,
    Ease.inOutCubic,
    Ease.outInCubic,
    
    Ease.inQuart,
    Ease.outQuart,
    Ease.inOutQuart,
    Ease.outInQuart,
    
    Ease.inQuint,
    Ease.outQuint,
    Ease.inOutQuint,
    Ease.outInQuint,
    
    Ease.inSine,
    Ease.outSine,
    Ease.inOutSine,
    Ease.outInSine,
    
    Ease.inExpo,
    Ease.outExpo,
    Ease.inOutExpo,
    Ease.outInExpo,
    
    Ease.inCirc,
    Ease.outCirc,
    Ease.inOutCirc,
    Ease.outInCirc,
    
    Ease.inElastic,
    Ease.outElastic,
    Ease.inOutElastic,
    Ease.outInElastic,
    
    Ease.inBack,
    Ease.outBack,
    Ease.inOutBack,
    Ease.outInBack,
    
    Ease.inBounce,
    Ease.outBounce,
    Ease.inOutBounce,
    Ease.outInBounce
    
}Ease.;

static inline NSString* easeToString(Ease. ease)
{
    if ((int)ease <= [EASE_STRINGS count] - 1)
    {
        return [EASE_STRINGS objectAtIndex:(int)ease];
    }
    return nil;
}

#endif /* Ease_h */

