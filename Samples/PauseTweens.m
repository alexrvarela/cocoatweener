//
//  PauseTweens.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/13/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "PauseTweens.h"
#import "CocoaTweener.h"

@implementation PauseTweens

-(id)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:210.0f/255.0f blue:210.0f/255 alpha:1.0f];
        self.clipsToBounds = YES;
        
        CGSize screenSize = UIScreen.mainScreen.bounds.size;
        
        PDFImageView* pdfView = [[PDFImageView alloc] init];
        [pdfView loadFromBundle:@"clouds1"];
        
        self.clouds1 = [[UIView alloc] initWithFrame:pdfView.bounds];
        self.clouds1.backgroundColor = [UIColor colorWithPatternImage:pdfView.image];
        self.clouds1.frame = CGRectMake(0.0f,
                                        screenSize.height * 0.2f,
                                        self.clouds1.frame.size.width * 2.0f,
                                        self.clouds1.frame.size.height);
        [self addSubview:self.clouds1];
        
        [pdfView loadFromBundle:@"clouds2"];
        self.clouds2 = [[UIView alloc] initWithFrame:pdfView.bounds];
        self.clouds2.backgroundColor = [UIColor colorWithPatternImage:pdfView.image];
        self.clouds2.frame = CGRectMake(0.0f,
                                        screenSize.height * 0.35f,
                                        self.clouds2.frame.size.width * 2.0f,
                                        self.clouds2.frame.size.height);
        [self addSubview:self.clouds2];
        
        [pdfView loadFromBundle:@"clouds3"];
        self.clouds3 = [[UIView alloc] initWithFrame:pdfView.bounds];
        self.clouds3.backgroundColor = [UIColor colorWithPatternImage:pdfView.image];
        self.clouds3.frame = CGRectMake(0.0f,
                                        screenSize.height * 0.5f,
                                        self.clouds3.frame.size.width * 2.0f,
                                        self.clouds3.frame.size.height);
        [self addSubview:self.clouds3];
        
        //button
        [self cloud1Tween];
        [self cloud2Tween];
        [self cloud3Tween];
        
        self.pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(20.0f,
                                                                          self.frame.size.height -  70.0f,
                                                                          self.frame.size.width - 40.0f,
                                                                          50.0f)];
        [self.pauseButton setTitle:@"PAUSE TWEENS" forState:UIControlStateNormal];
        [self.pauseButton addTarget:self action:@selector(playPause) forControlEvents:UIControlEventTouchUpInside];
        [self.pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.pauseButton.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:230.0f/255.0f blue:240.0f/255 alpha:1.0f];
        self.pauseButton.layer.cornerRadius = 7.0f;
        [self addSubview:self.pauseButton];
        
        //[self playPause];
    }
    
    return self;
}

-(void)playPause
{
    self.paused = !self.paused;
    
    if (self.paused)
    {
        [self.pauseButton setTitle:@"RESUME TWEENS" forState:UIControlStateNormal];
        
        [CocoaTweener pauseTweens:self.clouds1];
        [CocoaTweener pauseTweens:self.clouds2];
        [CocoaTweener pauseTweens:self.clouds3];
    }
    else
    {
        [self.pauseButton setTitle:@"PAUSE TWEENS" forState:UIControlStateNormal];
        
        [CocoaTweener resumeTweens:self.clouds1];
        [CocoaTweener resumeTweens:self.clouds2];
        [CocoaTweener resumeTweens:self.clouds3];
    }
}

-(void)cloud1Tween
{
    CGRect nFrame = self.clouds1.frame;
    nFrame.origin.x = -self.clouds1.frame.size.width / 2.0f;
    
    [CocoaTweener addTween:[[Tween alloc] init:self.clouds1
                                      duration:6.0f
                                          ease:kEaseNone
                                          keys:@{
                                                 @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                 }
                                         delay:0.0f
                                    completion:^{
                                        CGRect cFrame =  self.clouds1.frame;
                                        cFrame.origin.x = 0;
                                        self.clouds1.frame = cFrame;
                                        [self cloud1Tween];
                                    }
                            ]];
}


-(void)cloud2Tween
{
    CGRect nFrame = self.clouds2.frame;
    nFrame.origin.x = -self.clouds2.frame.size.width / 2.0f;
    
    [CocoaTweener addTween:[[Tween alloc] init:self.clouds2
                                      duration:4.0f
                                          ease:kEaseNone
                                          keys:@{
                                                 @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                 }
                                         delay:0.0f
                                    completion:^{
                                        CGRect cFrame =  self.clouds2.frame;
                                        cFrame.origin.x = 0;
                                        self.clouds2.frame = cFrame;
                                        [self cloud2Tween];
                                    }
                            ]];
}

-(void)cloud3Tween
{
    CGRect nFrame = self.clouds3.frame;
    nFrame.origin.x = -self.clouds3.frame.size.width / 2.0f;
    
    [CocoaTweener addTween:[[Tween alloc] init:self.clouds3
                                      duration:2.0f
                                          ease:kEaseNone
                                          keys:@{
                                                 @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                 }
                                         delay:0.0f
                                    completion:^{
                                        CGRect cFrame =  self.clouds3.frame;
                                        cFrame.origin.x = 0;
                                        self.clouds3.frame = cFrame;
                                        [self cloud3Tween];
                                    }
                            ]];
}

@end
