//
//  Tween.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

typedef enum
{
    kTweenStateInitial,
    kTweenStateStarted,
    kTweenStatePaused,
    kTweenStateOver
}
kTweenState;

#import <Foundation/Foundation.h>

#import "Tween.h"
#import "TweenValues.h"

//TODO: rename to TweenControl
@interface TweenControl : NSObject

//Target
@property (strong, nonatomic) Tween* tween;
//Transition
@property (strong) NSInvocation *invocation;
@property (strong) NSDictionary *transitionParams;
@property (strong) NSDictionary<NSString*, TweenValues*> * properties;
//Time
@property (nonatomic) float timeStart;
@property float timeComplete;
@property float timePaused;
@property float isTimelineTween;
//Tween states
@property (nonatomic) kTweenState state;
@property (nonatomic, readonly) kTweenState lastState;
//Constructor
-(id)init:(Tween*)tween timeStart:(float)timeStart;
//Setup
-(void)setupController;
-(void)updateTimeComplete;
-(void)resetState;
//Accesors
-(void)setKeys:(NSDictionary*)keys;
-(BOOL)completed;

@end
