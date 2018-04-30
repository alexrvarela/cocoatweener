//
//  Timeline.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweenControl.h"

typedef enum
{
    kTimelinePlayModeOnce,//remove automatically from engine
    kTimelinePlayModeLoop,//forever
    kTimelinePlayModePingPong//forever
}kTimelinePlayMode;

//private
typedef enum
{
    kTimelineStateInitial,//added, not started
    kTimelineStateStarted,//added, has started
    kTimelineStatePaused,//removed, paused
    kTimelineStateOver//removed, completed
}
kTimelineState;

@interface Timeline : NSObject

@property (nonatomic, readonly) NSMutableArray<TweenControl*>* controllerList;

@property kTimelinePlayMode playMode;//Move to timeline

//Tween engine properties, make private
@property (nonatomic) float timeStart;

@property float duration;
@property float timeComplete;
@property float timePaused;
@property float timeCurrent;//use for time paused

@property (nonatomic) kTimelineState state;
@property kTimelineState lastState;

@property BOOL reverse;//TODO:add setter invert time update if paused
@property int loops;//TODO:
@property (nonatomic, readonly) float loopCount;//TODO:

-(void)addTween:(Tween*)tween;
-(void)play;//add to engine
-(void)pause;//store time and remove from engine
-(void)rewind;//reset stored time
-(void)stop;//remomve from engine
-(void)goToTime:(float)time;//set time
-(BOOL)isAdded;//Deprecate
-(void)reset;

@end
