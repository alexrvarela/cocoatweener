//
//  SimpleTween.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/30/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "SimpleTween.h"
#import <CocoaTweener/CocoaTweener.h>

@implementation SimpleTween


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = UIColor.whiteColor;
        
        //View
        self.view = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 100.0f, 100.0f)];
        self.view.alpha = 0.25f;
        self.view.backgroundColor = [UIColor redColor];
        [self addSubview:self.view];
        
        
        //Button
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(20.0f,
                                                                      self.frame.size.height -  70.0f,
                                                                      self.frame.size.width - 40.0f,
                                                                      50.0f)];
        [self.button setTitle:@"ADD TWEEN" forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(addTween) forControlEvents:UIControlEventTouchUpInside];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.button.backgroundColor = UIColor.blackColor;
        self.button.layer.cornerRadius = 7.0f;
        [self addSubview:self.button];

    }
    
    return self;
}

-(void)addTween
{
    //Set initial states
    self.view.alpha = 0.25f;
    self.view.frame = CGRectMake(20.0f, 20.0f, 100.0f, 100.0f);
    self.view.backgroundColor = [UIColor redColor];
    
    //Create tween
    Tween* tween = [[Tween alloc] init:self.view//Target
                              duration:1.0f//One second
                                  ease:kEaseInOutCubic//Transition
                                  keys:@{@"alpha" : [NSNumber numberWithFloat:1.0f],
                                         @"frame" : [NSValue valueWithCGRect:CGRectMake(20.0f, 20.0f, 280.0f, 280.0f)],
                                         @"backgroundColor" : [UIColor blueColor]
                                         }];
    //Add tween
    [CocoaTweener addTween:tween];
}


@end
