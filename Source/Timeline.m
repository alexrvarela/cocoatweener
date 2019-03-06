//
//  Timeline.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "Timeline.h"
#import "TweenValues.h"
#import "CocoaTweener.h"

@implementation Timeline

//constructor
-(id)init
{
    self = [super init];
    
    if(self)
    {
        _controllerList = [[NSMutableArray alloc] init];//store tweens and time start in timeline
        self.loops = 0;//infinite by default
        
        /*
        self.timePaused = 0;
        self.updatesSkipped = 0;
        self.skipUpdates = 0;
        self.hasStarted = NO;
        self.isOver = NO;
        //*/
    }
    
    return self;
}

#pragma mark - Add Tweens
//TODO: add Tween only

-(void)addTween:(Tween*)tween //TODO add delay ?
{
    printf("add tween to timeline!\n");
    //tween make //TODO:use same function to construct [CocoaTweener addTween:tween];

    //Make controller
    TweenControl* nController = [[TweenControl alloc] init:tween
                                                       timeStart:tween.timeDelay / [CocoaTweener getTimeScale]];
    nController.isTimelineTween = YES;
    
    //TODO:Bind parameters
    
    //[nTween setKeys:tween.keys];//set values
    
    //Add to list
    
    if (self.controllerList != nil)
    {
        // Remove other tweenings that occur at the same time
        //TODO:pass list
        
        /*
        //TODO: Move to CocoaTweener add Timeline event, timeline overrides runtime tweens
        if (params.overwrite)[self removeTweensByTime:target
                                           properties:nTween.properties
                                            timeStart:nTween.timeStart
                                         timeComplete:nTween.timeComplete];
        //*/
        
        [self.controllerList addObject:nController];
        [self updateTime];
    }
};

//reset all controls
-(void)reset
{
    //iterate and reset all
    [self updateTime];
    [self resetStates];
}

-(void)resetStates
{
    for (TweenControl* tc in self.controllerList)
    {
        [tc resetState];
    }
}

-(void)setTimeStart:(float)timeStart
{
    _timeStart = timeStart;
    [self updateTime];
}

-(void)updateTime//TODO:rename updateTimeComplete
{
    self.timeComplete = self.timeStart;
    
    float m = 0;
    for (TweenControl* tc in self.controllerList)
    {
        tc.timeStart = tc.tween.timeDelay / [CocoaTweener getTimeScale];
        m = MAX(m, tc.timeComplete);
    }
    
    self.duration = m;
    self.timeComplete = self.timeStart + self.duration;
}

-(void)removeTween:(id)scope
{
    [self updateTime];
}

-(void)removeAllTweens
{
    //Destroy all
    [self updateTime];
}

#pragma mark - Editing
-(void)play
{
    printf("Timeline play\n");
    if (![self isAdded])
    {
        // && self.state != kTimelineStatePaused
        printf("not added, play\n");
        [CocoaTweener addTimeline:self delay:0.0f];
    }else
    {
        printf("is paused, resume\n");
        [CocoaTweener resumeTimeline:self];
    }
}

-(void)pause
{
    printf("Timeline pause\n");
    [CocoaTweener pauseTimeline:self];//TODO:
}


-(void)rewind
{
    printf("Timeline rewind\n");
    if(![self isAdded])
    {
        [CocoaTweener setCurrentTime:0.0f toTimeline:self];
    }
    else
    {
        [self stop];
        [self play];
    }
}

-(void)stop
{
    printf("Timeline stop\n");
    [CocoaTweener removeTimeline:self];
}

-(void)goToTime:(float)time//TODO: deprecate?
{
    [CocoaTweener setCurrentTime:time toTimeline:self];
}

-(void)setState:(kTimelineState)state
{
    _lastState = _state;
    _state = state;
}

-(BOOL)isAdded
{
    NSUInteger i = [CocoaTweener getTimelineIndex:self];
    
    if(i != NSNotFound)
    {
        return  YES;
    }
    
    return  NO;
}

/*
-(void)dealloc
{
    printf("timeline released\n");
}
//*/

@end
