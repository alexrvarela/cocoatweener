//
//  CocoaTweener.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//
//  Licensed under the MIT License
//
//  Based in Tweener, AS3 Library by Zeh Fernando, Nate Chatellier, Arthur Debert and Francis Turmel
//  Ported by Alejandro Ramirez Varela on 2012 and released as open source in 2018

#import <Foundation/Foundation.h>
#import "TweenControl.h"
#import "Timeline.h"
#import "Tween.h"
#import "Ease.h"

@interface CocoaTweener : NSObject

//Time
+(float)getCurrentTime;//public
+(void)setTimeScale:(float)tScale;//public
+(float)getTimeScale;//public

//  Tweens

//Add Tweens
+(void)addTween:(Tween*)tween;
//Remove tweens
+(BOOL)removeTween:(Tween*)tween;//TODO:remove by specific Tween id
+(BOOL)removeTweens:(id)target;
+(BOOL)removeAllTweens;
//Pause tweens
+(BOOL)pauseTweens:(id)target keyPaths:(NSArray*)keys;
+(BOOL)pauseTweens:(id)target;//TODO:
+(BOOL)pauseAllTweens;
//Resume tweens
+(BOOL)resumeTweens:(id)target keyPaths:(NSArray*)keys;
+(BOOL)resumeTweens:(id)target;//TODO:
+(BOOL)resumeAllTweens;//TODO:

//  Timelines

//Add timelines
+(void)addTimeline:(Timeline*)timeline delay:(float)delay;
//Remove timelines
+(BOOL)removeTimeline:(Timeline*)timeline;//to remove specific timeline just call [timeline stop]
+(BOOL)removeAllTimelines;
//Pause timelines
+(void)pauseTimeline:(Timeline*)timeline;
+(BOOL)pauseAllTimelines;//TODO:
//TODO:Resume timelines
+(void)resumeTimeline:(Timeline*)timeline;
+(BOOL)resumeAllTimelines;//TODO:
//Interact with timelines
+(void)setCurrentTime:(float)time toTimeline:(Timeline*)timeline;
+(NSInteger)getTimelineIndex:(Timeline*)timeline;

@end
