//
//  CocoaTweener.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocoaTweener.h"

static NSMutableArray<TweenControl*>* controlList;
static NSMutableArray<Timeline*>* timelineList;
static NSDate *initTime;
static NSTimer *tickTimer;

static float currentTime;
static float timeScale = 1.0f;

static BOOL initied = NO;
static BOOL isTweening = NO;
static BOOL autoOverwrite = YES;

@implementation CocoaTweener

#pragma mark - Initialize

+(void)initialize
{
    timelineList = [[NSMutableArray alloc] init];
    controlList = [[NSMutableArray alloc] init];
    initTime = [[NSDate alloc] init];
    autoOverwrite = YES;
    initied = YES;
    timeScale = 1.0f;
}

+(BOOL)initied{return initied;}//accesor

#pragma mark - Add Tween
+(void)addTween:(Tween*)tween
{
    if (tween == nil || tween.target == nil || tween.keys == nil)return;//TODO: log warning
    
    // Creates the main engine if it isn't active
    if (!initied)[self initialize];
    if(!isTweening || tickTimer == nil)[self start];
    
    //Make controller
    TweenControl* tc = [[TweenControl  alloc] init:tween
                                                  timeStart:currentTime + (tween.timeDelay / timeScale)];
    
    if (controlList != nil)
    {
        // Remove other tweenings that occur at the same time
        if (tween.overwrite)[self removeTweensByTime:tween.target
                                           properties:tc.properties
                                            timeStart:tc.timeStart
                                         timeComplete:tc.timeComplete
                                                list:controlList];
        
        [controlList addObject:tc];
        
        //if not deleted, it executes at the end of this frame execution
        if ( (currentTime + tc.timeStart <= currentTime &&
              currentTime + tc.timeComplete <= currentTime) )
        {
            NSInteger myT = [controlList count] - 1;
            [self updateTween:tc currentTime:[self getCurrentTime]];//replace
            [self removeTweenByIndex:[NSNumber numberWithInteger:myT] finalRemoval:NO list:controlList];
        }
    }
}

#pragma mark - Add Timeline

//TODO: delete delay
+(void)addTimeline:(Timeline*)timeline delay:(float)delay
{
    if (timeline.controllerList == nil || ![timeline.controllerList count])
    {
        //Empty timeline, add Tweens!
        printf("Warning, empty timeline, add Tweens to Timeline!\n");
        return;
    }

    // Creates the main engine if it isn't active
    if (!initied)[self initialize];
    if(!isTweening || tickTimer == nil)[self start];
    
    if (timelineList != nil && [timelineList indexOfObject:timeline] == NSNotFound)
    {
        [self resetTime:timeline delay:(timeline.state != kTimelineStatePaused) ? delay : -timeline.timePaused];
        timeline.state = kTimelineStateInitial;
        [timelineList addObject:timeline];
    }
}

+(void)resetTime:(Timeline*)timeline delay:(float)delay//TODO:use delay???
{
    timeline.timeStart = currentTime + (delay / timeScale);
    timeline.timePaused = 0.0f;//reste time paused
    [timeline reset];//Reset all controllers!
}

+(NSInteger)getTimelineIndex:(Timeline*)timeline;
{
    return [timelineList indexOfObject:timeline];
}

+(BOOL)removeTimeline:(Timeline*)timeline
{
    NSInteger indexTimeline = [self getTimelineIndex:timeline];
    
    if (indexTimeline != NSNotFound)
    {
        [timelineList removeObjectAtIndex:indexTimeline];
    }
    
    timeline.timePaused = 0.0f;
    timeline.state = kTimelineStateOver;
    
    return YES;
}


#pragma mark - Update
+(void)pauseTimeline:(Timeline*)timeline
{
    timeline.timePaused = timeline.timeCurrent - timeline.timeStart;
    if(timeline.state != kTimelineStatePaused)timeline.state = kTimelineStatePaused;
}

+(void)resumeTimeline:(Timeline*)timeline
{
    float timeStart = timeline.reverse ? -(timeline.duration - timeline.timePaused) : -timeline.timePaused;
    
    if([timelineList indexOfObject:timeline] == NSNotFound)
        [CocoaTweener addTimeline:timeline delay: timeStart];
    
    [self resetTime:timeline delay:timeStart];
    timeline.state = timeline.lastState;
}

+(BOOL)updateTweens
{
    if ([controlList count] == 0) return NO;
    
    for (NSInteger indexTween = 0; indexTween < ([controlList count]); indexTween++)
    {
        // Looping throught each Tweening and updating the values accordingly
        TweenControl* tc = [controlList objectAtIndex:indexTween];
        
        if (tc != nil && tc.state != kTweenStatePaused)
        {
            BOOL update =  [self updateTween:tc currentTime:[self getCurrentTime]];
            
            if (!update)[self removeTweenByIndex:[NSNumber numberWithInteger:indexTween] finalRemoval:NO list:controlList];
            
            if (tc.state == kTweenStateOver)
            {
                [self removeTweenByIndex:[NSNumber numberWithInteger:indexTween] finalRemoval:YES list:controlList];
                indexTween--;
            }
        }
    }
    
    return YES;
}

+(void)setCurrentTime:(float)cTime toTimeline:(Timeline*)timeline
{
    //Set boundaries
    if(cTime < 0.0f)currentTime = 0.0f;
    if(cTime > timeline.duration)cTime = timeline.duration;
    
    //reset timestart
    if(timeline.timeStart > 0)timeline.timeStart = 0.0f;
    
    //Update all tweens
    for (TweenControl* tc in timeline.controllerList)
    {
        //if( (cTime >= tc.timeStart) && (cTime < tc.timeComplete))
        [self updateValues:tc currentTime:cTime];
        
        //TODO:if timestart < time set start value
        //TODO:if timestart + timeComplete >= time set complete value
    }
    
    //set timeline values
    if(timeline.state != kTimelineStatePaused)timeline.state = kTimelineStatePaused;
    
    timeline.timePaused = cTime;
    timeline.timeCurrent = cTime;
}

//Update runloop timelines
+(BOOL)updateTimelines
{

    if ([timelineList count] == 0)return NO;
    
    //update timelines
    for (NSInteger indexTimeline = 0; indexTimeline < [timelineList count]; indexTimeline++)
    {
        Timeline* timeline = [timelineList objectAtIndex:indexTimeline];
        
        if (timeline.state != kTimelineStatePaused)
        {
            if (timeline.state == kTimelineStateOver)
            {
                [self removeTimeline:timeline];
                indexTimeline--;
            }else
            {
                if ([self getCurrentTime] >= timeline.timeStart)
                {
                    if (([self getCurrentTime] - timeline.timeStart) >= (timeline.timeComplete - timeline.timeStart))
                    {
                        if (timeline.playMode == kTimelinePlayModeOnce)
                        {
                            timeline.state = kTimelineStateOver;
                            [self removeTimeline:timeline];
                            indexTimeline--;
                        }
                        else
                        {
                            if (timeline.playMode == kTimelinePlayModePingPong)
                            {
                                //invert and reset time
                                timeline.reverse = !timeline.reverse;
                            }
                            else if (timeline.playMode == kTimelinePlayModeLoop)
                            {
                                //TODO: handle loop count
                                
                                /*
                                 if (timeline.loops > 0)
                                 {
                                 }
                                 //*/
                            }

                            timeline.state = kTimelineStateInitial;
                            [self resetTime:timeline delay:0.0f];//Play again!
                        }
                    }
                    else
                    {

                        float timelineTime = [self getCurrentTime] - timeline.timeStart;

                        //Update all timeline Tweens
                        
                        for (NSInteger indexTween = 0; indexTween < ([timeline.controllerList count]); indexTween ++)
                        {
                            // Looping throught each Tweening and updating the values accordingly
                            
                            TweenControl* tc = [timeline.controllerList objectAtIndex:indexTween];
                            
                            //Ignore if tween is paused or not, controlled by timeline
                            if (!timeline.reverse)
                            {
                                //Use engine, enable Tween handlers
                                //if( ((timelineTime >= tc.timeStart) && (timelineTime < tc.timeComplete)))//if timeline !started update
                                [self updateTween:tc currentTime:timelineTime];
                            }else
                            {
                                //Update values directly, ignore Tween handlers if timeline direction is reversed
                                //TODO:Update if tween is in time range calculate reverse range
                                [self updateValues:tc currentTime:timeline.duration - timelineTime];
                            }
                        }
                        
                        if(timeline.state != kTimelineStateStarted)
                        {
                            timeline.state = kTimelineStateStarted;
                        }
                        
                        timeline.timeCurrent = timeline.reverse ? (timeline.timeComplete - timelineTime) : [self getCurrentTime];
                    }
                }
                
            }//timeline paused
        }//end for
    }
    
    return YES;
}
//*/

//Foward update
+(BOOL)updateTween:(TweenControl*)tweenControl currentTime:(float)currentTime
{
//    printf("updateTween\n");
    if (tweenControl == nil || tweenControl.tween.target == nil || tweenControl.tween.keys == nil) return NO;

    if (currentTime >= tweenControl.timeStart && tweenControl.state != kTweenStateOver)
    {
        if (currentTime >= tweenControl.timeComplete)
        {
            // Whether or not it's over the update time
            tweenControl.state = kTweenStateOver;
            
            //On complete
            if (tweenControl.tween.onCompleteHandler != nil)
            {
                tweenControl.tween.onCompleteHandler();
            }
        }
        
        if (tweenControl.state != kTweenStateStarted && tweenControl.state != kTweenStateOver)
        {
            tweenControl.state = kTweenStateStarted;
            
            //refresh properties!
            if (!tweenControl.isTimelineTween && tweenControl.tween.timeDelay > 0.0f){[tweenControl setupController];}
            
            if (tweenControl.tween.onStartHandler != nil)
            {
                tweenControl.tween.onStartHandler();
            }
        }
        
        //Update values
        [self updateValues:tweenControl currentTime:currentTime];
        
        //On update
        if (tweenControl.tween.onUpdateHandler != nil)
        {
            tweenControl.tween.onUpdateHandler();
        }
        
        BOOL isOver = (tweenControl.state == kTweenStateOver);
        return (!isOver);
    }else
    {
//        if(tweenControl.state == kTweenStateInitial)printf("tween not started\n");
//        if(tweenControl.state == kTweenStateOver)printf("tween is over\n");
    }
    
    // On delay, hasn't started, so returns true
    return YES;
}

+(BOOL)updateValues:(TweenControl*)tweenControl currentTime:(float)cTime//Add reverse time?
{
    //TODO:Use Ease.h
    
    if (tweenControl == nil || tweenControl.tween.target == nil || tweenControl.tween.keys == nil) return NO;
    
    float* nv;// New value for each property
    float t;// current time
    float b;// beginning value
    float c;// change in value
    float d;// duration
    
    for (NSString *key in tweenControl.properties)
    {
        BOOL allocated = NO;
        TweenValues *tProperty = [tweenControl.properties valueForKey:key];
        id target = tweenControl.tween.target;
        
        if (cTime < tweenControl.timeStart)
        {
            //Just set it to the initial value
            nv = tProperty.valueStart;
        }
        else if (cTime >= tweenControl.timeComplete)
        {
            //Just set it to the final value
            nv = tProperty.valueComplete;
        } else
        {   
            nv = malloc(sizeof(float) * (tProperty.size));
            allocated = YES;
            
            t = cTime - tweenControl.timeStart;
            d = tweenControl.timeComplete - tweenControl.timeStart;
            
            for(NSInteger indexFLoat = 0; indexFLoat < tProperty.size; indexFLoat++)
            {
                b = tProperty.valueStart[indexFLoat];
                c = tProperty.valueComplete[indexFLoat] - tProperty.valueStart[indexFLoat];
                
                //Apply equation formula
                double returnedValue = tweenControl.tween.ease(t, b, c, d);
                
                if (isnan(returnedValue))
                    nv[indexFLoat] = tProperty.valueComplete[indexFLoat];
                else
                    nv[indexFLoat] = returnedValue;
            }
        }
        
        //Set property
        //TODO:add NSUinteger  and CGFloat
        
        NSString * typeString = [KVCUtils getTypeString:[target valueForKey:key]];
        
        if([typeString isEqualToString:[NSString stringWithUTF8String:@encode(float)]])
            [target setValue:[NSNumber numberWithFloat:nv[0]] forKeyPath:key];
        
        else if([typeString isEqualToString:[NSString stringWithUTF8String:@encode(double)]])
            [target setValue:[NSNumber numberWithDouble:(double)nv[0]] forKeyPath:key];
        
        else if([typeString isEqualToString:[NSString stringWithUTF8String:@encode(int)]])
            [target setValue:[NSNumber numberWithInt:(int)nv[0]] forKeyPath:key];
        
        else if([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGPoint)]])
            [target setValue:[NSValue valueWithCGPoint:CGPointMake(nv[0], nv[1])] forKeyPath:key];
        
        else if([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGSize)]])
            [target setValue:[NSValue valueWithCGSize:CGSizeMake(nv[0], nv[1])] forKeyPath:key];
        
        else if([typeString isEqualToString:[NSString stringWithUTF8String:@encode(CGRect)]])
            [target setValue:[NSValue valueWithCGRect:CGRectMake(nv[0], nv[1], nv[2], nv[3])] forKeyPath:key];
        
        else if([typeString isEqualToString:[NSString stringWithUTF8String:@encode(UIColor)]])
            [target setValue:[UIColor colorWithRed:(CGFloat)nv[0] green:(CGFloat)nv[1] blue:(CGFloat)nv[2] alpha:1.0f] forKeyPath:key];
        
        if(allocated)free(nv);
    }
    
    return YES;
}

#pragma mark - Remove tweens
+(BOOL)removeTweenByIndex:(NSNumber*)index list:(NSMutableArray<TweenControl*>*)list
{
    return [self removeTweenByIndex:index finalRemoval:YES list:list];
}

+(BOOL)removeTweenByIndex:(NSNumber*)index finalRemoval:(BOOL)removal list:(NSMutableArray<TweenControl*>*)list
{
    TweenControl* tweenControl = [list objectAtIndex:[index integerValue]];
    tweenControl.state = kTweenStateOver;
    
    if (removal)
    {
        [list removeObjectAtIndex:[index integerValue]];
        tweenControl  = nil;
    }
    
    return YES;
}

+(BOOL)removeTweensByTime:(id)target
               properties:(NSDictionary*)p_properties
                timeStart:(float)p_timeStart
             timeComplete:(float)p_timeComplete
                     list:(NSMutableArray<TweenControl*>*)list
{
    printf("remove tweens by time\n");
    
    BOOL removed = NO;
    BOOL removedLocally;
    
    NSInteger i;
    NSInteger tl = [list count];
    
    NSString* pName;
    
    for (i = 0; i < tl; i++) {
        
        if ([list objectAtIndex:i] != nil && target == [list objectAtIndex:i].tween.target)
        {
            // Same object...
            if (p_timeComplete > [[list objectAtIndex:i] timeStart] && p_timeStart < [[list objectAtIndex:i] timeComplete])
            {
                // New time should override the old one...
                removedLocally = NO;
                for (pName in [[list objectAtIndex:i] properties])
                {
                    if([p_properties objectForKey:pName] != nil)
                    {
                        // Same object, same property
                        if ([list objectAtIndex:i].tween.onOverwriteHandler != nil)
                        {
                            [list objectAtIndex:i].tween.onOverwriteHandler();
                        }
                        
                        // Finally, remove this old tweening and use the new one
                        removedLocally = YES;
                        removed = YES;
                    }
                }
                
                if (removedLocally)
                {
                    if ([[[list objectAtIndex:i] properties] count] == 0)
                        [self removeTweenByIndex:[NSNumber numberWithInteger:i] finalRemoval:NO list:list];
                }
            }
        }
    }
    
    return removed;
}

//Remove al tweens from a specific target
+(BOOL)removeTweens:(id)target list:(NSMutableArray<TweenControl*>*)list
{
    NSMutableArray* properties = [[NSMutableArray alloc] init];//collect all keys from specific target;
    NSString* pName;
    NSInteger i;
    
    for (i = 0; i < [list count]; i++)
    {
        if ([list objectAtIndex:i] != nil && target == [list objectAtIndex:i].tween.target)
        {
            for (pName in [[list objectAtIndex:i] properties])
            {
                if ([properties indexOfObject:pName inRange:NSMakeRange(0, [properties count])] == NSNotFound)
                    [properties addObject:pName];
            }
        }
    }
    
    BOOL affected = [self affectTweens:@selector(removeTweenByIndex:list:) target:target properties:properties list:list];
    
    properties  = nil;
    
    return affected;
}

+(BOOL)removeTweens:(id)target
{
    return [self removeTweens:target list:controlList];
}

+(BOOL)removeTweens:(id)target keyPaths:(NSArray*)keys
{
    return [self removeTweens:target keyPaths:keys list:controlList];
}

//remove al tween keys from a specific target
+(BOOL)removeTweens:(id)target keyPaths:(NSArray*)keys list:(NSMutableArray<TweenControl*>*)list
{
    // Create the property list
    NSMutableArray* properties = [[NSMutableArray alloc] init];
    
    NSInteger i;
    
    for (i = 0; i < [keys count]; i++)
    {
        if([[keys objectAtIndex:i] isKindOfClass:[NSString class]] &&
           [properties indexOfObject:[keys objectAtIndex:i] inRange:NSMakeRange(0, [properties count])] == NSNotFound)
        {
            [properties addObject:[keys objectAtIndex:i]];
        }
    }
    
    return  [self affectTweens:@selector(removeTweenByIndex:list:) target:target properties:properties list:list];
}

//Remove all tweens from runloop
+(BOOL)removeAllTweens:(NSMutableArray<TweenControl*>*)list
{
    if (list == nil || [list count] == 0) return NO;
    
    BOOL removed = NO;
    NSInteger indexTween;
    
    for (indexTween = 0; indexTween < [list count]; indexTween++)
    {
        [self removeTweenByIndex:[NSNumber numberWithInteger:indexTween] finalRemoval:NO list:list];
        removed = YES;
    }
    
    return removed;
}

+(BOOL)removeAllTweens{return [self removeAllTweens:controlList];}

#pragma mark - Pause tweens
+(BOOL)pauseTweens:(id)target{return [self pauseTweens:target keyPaths:@[]];}

+(BOOL)pauseTweens:(id)target keyPaths:(NSArray*)keys //list:(NSMutableArray<TweenControl*>*)list
{
    // Create the property list
    NSMutableArray* properties = [[NSMutableArray alloc] init];//collect all keys from specific target;
    NSInteger i;
    
    for (i = 0; i < [keys count]; i++)
    {
        if([[keys objectAtIndex:i] isKindOfClass:[NSString class]]
           && [properties indexOfObject:[keys objectAtIndex:i] inRange:NSMakeRange(0, [properties count])] == NSNotFound)
        {
            [properties addObject:[keys objectAtIndex:i]];
        }
    }
    
    return  [self affectTweens:@selector(pauseTweenByIndex:list:) target:target properties:properties list:controlList];
}

+(BOOL)pauseAllTweens
{
    return [self pauseAllTweens:controlList];//runloop tweens
}

+(BOOL)pauseAllTweens:(NSMutableArray<TweenControl*>*)list
{
    if (!list || ![list count]) return NO;
    
    BOOL paused = NO;
    
    for (NSInteger i = 0; i < [list count]; i++)
    {
        [self pauseTweenByIndex:[NSNumber numberWithInteger:i] list:list];
        paused = true;
    }
    
    return paused;
}

+(BOOL)resumeTweens:(id)target
{
    return [self resumeTweens:target keyPaths:@[]];
}

+(BOOL)resumeTweens:(id)target keyPaths:(NSArray*)keys
{
    // Create the property list
    NSMutableArray* properties = [[NSMutableArray alloc] init];//collect all keys from specific target;
    NSInteger i;
    
    for (i = 0; i < [keys count]; i++)
    {
        //detect id
        if([[keys objectAtIndex:i] isKindOfClass:[NSString class]]
           && [properties indexOfObject:[keys objectAtIndex:i] inRange:NSMakeRange(0, [properties count])] == NSNotFound)
        {
            [properties addObject:[keys objectAtIndex:i]];
        }
    }

    return  [self affectTweens:@selector(resumeTweenByIndex:list:) target:target properties:properties list:controlList];
}


+(BOOL)resumeAllTweens
{
    return [self resumeAllTweens:controlList];//runloop tweens
}

+(BOOL)resumeAllTweens:(NSMutableArray<TweenControl*>*)list
{
    if (!list || ![list count]) return NO;
    
    BOOL resumed = false;
    
    for (NSInteger i = 0; i < [list count]; i++)
    {
        [self resumeTweenByIndex:[NSNumber numberWithInteger:i] list:list];
        resumed = true;
    }
    
    return resumed;
}

+(BOOL)pauseTweenByIndex:(NSNumber*)index list:(NSMutableArray<TweenControl*>*)list
{
    TweenControl* tc = [list objectAtIndex:[index integerValue]];
    
    if (tc.state == kTweenStatePaused) return NO;
    tc.timePaused = [self getCurrentTime] - tc.timeStart;
    tc.state = kTweenStatePaused;
    
    return YES;
}

+(BOOL)resumeTweenByIndex:(NSNumber*)index list:(NSMutableArray<TweenControl*>*)list
{
    TweenControl* tc = [list objectAtIndex:[index integerValue]];

    if (tc.state != kTweenStatePaused) return NO;
    
    float cTime = [self getCurrentTime];
    tc.timeStart = cTime - tc.timePaused;
    tc.timePaused = 0.0f;
    tc.state = tc.lastState;//resume
    return YES;
}

#pragma mark - Affect / split tweens

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

+(BOOL)affectTweens:(SEL)selector
             target:(id)target
         properties:(NSArray*)p_properties
               list:(NSMutableArray<TweenControl*>*)list
{
    BOOL affected = NO;
    NSInteger i;
    
    if (list == nil || [list count] == 0) return NO;
    
    for (i = 0; i < [list count]; i++)
    {
        if ([list objectAtIndex:i] != nil && target == [list objectAtIndex:i].tween.target)
        {
            if ([p_properties count] == 0)
            {
                if ([self respondsToSelector:selector])
                    [self performSelector:selector
                               withObject:[NSNumber numberWithInteger:i]
                               withObject:list];

                affected = YES;
                
            } else
            {
                // Must check whether this tween must have specific properties affected
                NSMutableArray* affectedProperties = [[NSMutableArray alloc] init];
                
                NSInteger j;
                
                for (j = 0; j < [p_properties count]; j++)
                {
                    if([[[list objectAtIndex:i] properties] objectForKey:[p_properties objectAtIndex:j]] != nil){
                        [affectedProperties addObject:[p_properties objectAtIndex:j]];
                    }
                }
                
                if ([affectedProperties count] > 0)
                {
                    // This tween has some properties that need to be affected
                    NSInteger objectProperties = [[[list objectAtIndex:i] properties] count];
                    
                    if (objectProperties == [affectedProperties count])
                    {
                        //The list of properties is the same as all properties, so affect it all
                        if ([self respondsToSelector:selector])
                            [self performSelector:selector
                                       withObject:[NSNumber numberWithInteger:i]
                                       withObject:list];

                        affected = YES;
                        
                    } else
                    {
                        // The properties are mixed, so split the tween and affect only certain specific properties
                        NSInteger slicedTweenIndex = [self splitTweens:[NSNumber numberWithInteger:i] properties:affectedProperties list:list];

                        if ([self respondsToSelector:selector])
                            [self performSelector:selector
                                       withObject:[NSNumber numberWithInteger:slicedTweenIndex]
                                       withObject:list];
                        
                        affected = YES;
                    }
                }

                affectedProperties  = nil;
            }
        }
    }
    
    return affected;
}

#pragma clang diagnostic pop

+(NSInteger)splitTweens:(NSNumber*)index properties:(NSArray*)p_properties list:(NSMutableArray<TweenControl*>*)list
{
    printf("split\n");
    // First, duplicates
    TweenControl* originalTween = [list objectAtIndex:[index integerValue]];
    TweenControl* newTween = [self clone:[list objectAtIndex:[index integerValue]] omitEvents:NO];//splitProperties:p_properties
    
    NSMutableDictionary *nProperties = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *oProperties = [[NSMutableDictionary alloc] init];
    
    NSString* pName;
    
    // Removes the unspecified properties from the new one
    for (pName in [originalTween properties])
    {
        NSInteger i;
        
        BOOL exists = NO;
        
        for (i = 0; i < [p_properties count]; i++)
        {
            if ([p_properties objectAtIndex:i] == pName)
            {
                exists = YES;
                break;
            }
        }
        
        TweenValues *property = [[originalTween properties] objectForKey:pName];
        //creates new one
        TweenValues *nProperty = [[TweenValues alloc] initWithStartValue:[property valueStart]
                                                                 valueComplete:[property valueComplete]
                                                         originalValueComplete:[property originalValueComplete]
                                                                     floatSize:[property size]];
        if (exists)
        {
            [nProperties setObject:nProperty forKey:pName];
            
        }else
        {
            [oProperties setObject:nProperty forKey:pName];
        }
    }
    
    // Now, removes tweenings where needed
    
    //replace new properties
    newTween.properties = nProperties;
    originalTween.properties = oProperties;
    nProperties  = nil;
    oProperties  = nil;

    // If there are empty property lists, a cleanup is done on the next updateTweens cycle
    [list addObject:newTween];
    
    return [list count] - 1;
}

#pragma mark - Runloop
+(void)tick:(NSTimer *)timer
{
    [self updateTime];
    
    BOOL hasUpdatedTweens = NO;
    BOOL hasUpdatedTimelines = NO;
    
    hasUpdatedTweens = [self updateTweens];
    hasUpdatedTimelines = [self updateTimelines];
    
    if(!hasUpdatedTweens && !hasUpdatedTimelines) [self stop];
}

+(void)start
{
    isTweening = YES;
    
    //reset
    if (controlList != nil){controlList  = nil;}
    if (initTime != nil){initTime = nil;}
    
    controlList = [[NSMutableArray alloc] init];
    initTime = [[NSDate alloc] init];
    
    if ([tickTimer isValid])[self invalidate];
    tickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 60.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
    [self updateTime];
}

+(void)stop
{
    isTweening = NO;
    if (controlList != nil){controlList = nil;}
    currentTime = 0;
    if ([tickTimer isValid])[self invalidate];
}

+(void)invalidate
{
    if([tickTimer isValid] || tickTimer != nil)
    {
        [tickTimer invalidate];
        tickTimer = nil;
    }
}

+(BOOL)isTweening{return isTweening;}//accesor

#pragma mark - Time
+(void)updateTime{currentTime = [[NSDate date] timeIntervalSinceDate:initTime];}
+(float)getCurrentTime{return currentTime;}//public accesor

#pragma mark - Clone
+(TweenControl*)clone:(TweenControl*)tween omitEvents:(BOOL)omitEvents
{
    TweenControl* nTween = [[TweenControl  alloc] init:[tween.tween copy] timeStart:tween.timeStart];

    nTween.state = tween.state;
    
    if (omitEvents)
    {
        nTween.tween.onStartHandler = nil;
        nTween.tween.onUpdateHandler = nil;
        nTween.tween.onCompleteHandler = nil;
        nTween.tween.onOverwriteHandler = nil;
    }
    
    return nTween;
}

+(void)setTimeScale:(float)tScale
{
    //TODO: Refresh all running tweens and timelines
    timeScale = tScale;
}

+(float)getTimeScale
{
    return timeScale;
}

#pragma mark - Memory
+(void)free
{
    [self removeAllTweens];
    [self invalidate];
    
    if(controlList != nil)
    {
        [controlList removeAllObjects];
        controlList = nil;
    }

    [self invalidate];
    if (initTime != nil)initTime = nil;
    
    currentTime = 0;
    initied = NO;
}

@end
