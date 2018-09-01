//
//  ViewController.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//


#import "ViewController.h"

//Engine
#import <CocoaTweener/CocoaTweener.h>

//Samples
#import "TouchPoint.h"
#import "AnimateText.h"
#import "PauseTweens.h"
#import "TimelineBasic.h"
#import "WindBlow.h"
#import "ScrollTimeline.h"
#import "PathLoop.h"
#import "ScrollAims.h"
#import "AnimateArcRadius.h"
#import "ArcOrbits.h"
#import "SimpleTween.h"
#import "TweenHandlers.h"

@interface ViewController ()

@end

@implementation ViewController

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.view.backgroundColor = [UIColor clearColor];
        
        self.container = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.view addSubview:self.container];
        
//        float spacing = 20.0f;
        float buttonWidth = (UIScreen.mainScreen.bounds.size.width) / 2.0f - 1.0;
        
        UIButton* prevButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                          UIScreen.mainScreen.bounds.size.height - 40.0f,
                                                                          buttonWidth,
                                                                          40.0f)];
        [prevButton setTitle:@"PREV" forState:UIControlStateNormal];
        [prevButton addTarget:self action:@selector(prev) forControlEvents:UIControlEventTouchUpInside];
        prevButton.backgroundColor = UIColor.blackColor;
        [self.view addSubview:prevButton];
        
        UIButton* nextButton = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - buttonWidth,
                                                                          UIScreen.mainScreen.bounds.size.height - 40.0f,
                                                                          buttonWidth,
                                                                          40.0f)];
        [nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
        nextButton.backgroundColor = UIColor.blackColor;
        [self.view addSubview:nextButton];

        
//        CGRect contentFrame = UIScreen.mainScreen.bounds;
        CGRect contentFrame = CGRectMake(0.0f,
                                        0.0f,
                                        UIScreen.mainScreen.bounds.size.width,
                                        UIScreen.mainScreen.bounds.size.height - 40.0f);
        
        [self.container addSubview:[[SimpleTween alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[TweenHandlers alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[ArcOrbits alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[AnimateArcRadius alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[ScrollAims alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[PathLoop alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[TouchPoint alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[AnimateText alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[PauseTweens alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[WindBlow alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[ScrollTimeline alloc] initWithFrame:contentFrame]];
        [self.container addSubview:[[TimelineBasic alloc] initWithFrame:contentFrame]];

        float x = 0.0f;
        
        for (UIView* view in self.container.subviews)
        {
            view.frame = CGRectMake(x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            x += UIScreen.mainScreen.bounds.size.width;
        }
        
        self.container.frame = CGRectMake(self.container.frame.origin.x, self.container.frame.origin.y, x, self.container.frame.size.height);
        
    }
    return self;
}

-(void)setPageIndex:(int)pageIndex
{
    printf("set page index : %i\n", pageIndex);
    float w = UIScreen.mainScreen.bounds.size.width;
    CGRect nFrame = self.container.frame;
    nFrame.origin.x = - (pageIndex * w);
    
    if([[self.container.subviews objectAtIndex:pageIndex] respondsToSelector:@selector(freeze)])
       [[self.container.subviews objectAtIndex:pageIndex] performSelector:@selector(freeze)];
        
    _pageIndex = pageIndex;
    
    [CocoaTweener removeTweens:self.view];//TODO: remove for key
    [CocoaTweener addTween:[[Tween alloc] init:self.container
                                       duration:0.5f
                                           ease:kEaseOutCubic
                                           keys:@{
                                                  @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                  }
                                          delay:0.0f
                             ]];

}

-(void)freeze
{
    
}

-(void)next
{
    if (self.pageIndex < self.container.subviews.count - 1)
        self.pageIndex += 1;
    else
        self.pageIndex = 0;
}

-(void)prev
{
    if (self.pageIndex > 0)
        self.pageIndex -= 1;
    else
        self.pageIndex = (int)self.container.subviews.count - 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //PAUSE ALL TWEENS
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
