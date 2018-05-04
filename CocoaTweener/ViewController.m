//
//  ViewController.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//


#import "ViewController.h"

//engine
#import "CocoaTweener.h"
#import "Tween.h"
//samples
#import "TouchPoint.h"
#import "AnimateText.h"
#import "PauseTweens.h"
#import "TimelineBasic.h"
#import "WindBlow.h"
#import "ScrollAnimation.h"

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
        
        float spacing = 20.0f;
        float buttonWidth = (UIScreen.mainScreen.bounds.size.width - spacing * 3.0f) / 2.0f;
        
        UIButton* prevButton = [[UIButton alloc] initWithFrame:CGRectMake(spacing,
                                                                          40.0f,
                                                                          buttonWidth,
                                                                          40.0f)];
        [prevButton setTitle:@"PREV" forState:UIControlStateNormal];
        [prevButton addTarget:self action:@selector(prev) forControlEvents:UIControlEventTouchUpInside];
        prevButton.layer.cornerRadius = 7.0f;
        prevButton.layer.borderColor = [UIColor whiteColor].CGColor;
        prevButton.layer.borderWidth = 2.0f;
        [self.view addSubview:prevButton];
        
        UIButton* nextButton = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - buttonWidth -spacing,
                                                                          40.0f,
                                                                          buttonWidth,
                                                                          40.0f)];
        [nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
        nextButton.layer.cornerRadius = 7.0f;
        nextButton.layer.borderColor = [UIColor whiteColor].CGColor;
        nextButton.layer.borderWidth = 2.0f;
        [self.view addSubview:nextButton];
        
        
        [self.container addSubview:[[TouchPoint alloc] init]];
        [self.container addSubview:[[AnimateText alloc] init]];
        [self.container addSubview:[[PauseTweens alloc] init]];
        [self.container addSubview:[[WindBlow alloc] init]];
        [self.container addSubview:[[ScrollAnimation alloc] init]];
        [self.container addSubview:[[TimelineBasic alloc] init]];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
