//
//  TweenParameters.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/1/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "Tween.h"

@implementation Tween

//default initializer
-(id)init:(id)target duration:(float)duration ease:(Equation)ease keys:(NSDictionary*)keys;
{
    self = [super init];
    
    if (self)
    {
        self.overwrite = NO;;
        self.target = target;
        self.duration = duration;
        self.ease = ease;
        self.keys = keys;
        self.timeDelay = 0.0f;
    }
    
    return self;
}

-(id)init:(id)target duration:(float)duration ease:(Equation)ease keys:(NSDictionary*)keys delay:(float)delay
{
    self =  [self init:(id)target duration:(float)duration ease:(Equation)ease keys:(NSDictionary*)keys];
    
    if (self)
    {
        self.timeDelay = delay;
    }
    
    return self;
}

//TODO: define useful initializers
-(id)init:(id)target duration:(float)duration ease:(Equation)ease keys:(NSDictionary*)keys delay:(float)delay completion:(TweenHandler)completion
{
    self = [self init:(id)target duration:(float)duration ease:(Equation)ease keys:(NSDictionary*)keys delay:delay];
    
    if (self)
    {
        self.onCompleteHandler = completion;
    }
    
    return self;
}

/*
-(void)dealloc
{
    printf("tween released\n");
}//*/

@end
