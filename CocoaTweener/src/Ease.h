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
    kEaseNone,
    kEaseInQuad,
    kEaseOutQuad,
    kEaseInOutQuad,
    kEaseOutInQuad,
    kEaseInCubic,
    kEaseOutCubic,
    kEaseInOutCubic,
    kEaseOutInCubic,
    
    kEaseInQuart,
    kEaseOutQuart,
    kEaseInOutQuart,
    kEaseOutInQuart,
    
    kEaseInQuint,
    kEaseOutQuint,
    kEaseInOutQuint,
    kEaseOutInQuint,
    
    kEaseInSine,
    kEaseOutSine,
    kEaseInOutSine,
    kEaseOutInSine,
    
    kEaseInExpo,
    kEaseOutExpo,
    kEaseInOutExpo,
    kEaseOutInExpo,
    
    kEaseInCirc,
    kEaseOutCirc,
    kEaseInOutCirc,
    kEaseOutInCirc,
    
    kEaseInElastic,
    kEaseOutElastic,
    kEaseInOutElastic,
    kEaseOutInElastic,
    
    kEaseInBack,
    kEaseOutBack,
    kEaseInOutBack,
    kEaseOutInBack,
    
    kEaseInBounce,
    kEaseOutBounce,
    kEaseInOutBounce,
    kEaseOutInBounce
    
}kEase;

static inline NSString* easeToString(kEase ease)
{
    if ((int)ease <= [EASE_STRINGS count] - 1)
    {
        return [EASE_STRINGS objectAtIndex:(int)ease];
    }
    return nil;
}

#endif /* Ease_h */

