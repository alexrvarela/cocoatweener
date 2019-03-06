//
//  TweenHandlers.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/31/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "TweenHandlers.h"
#import <CocoaTweener/CocoaTweener.h>

@implementation TweenHandlers


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = UIColor.whiteColor;
        
        //View
        self.view = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 50.0f, 50.0f)];
        self.view.backgroundColor = UIColor.blackColor;
        self.view.layer.cornerRadius = 25.0f;
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
    //Remove old tween
    [CocoaTweener removeTweens:self.view keyPaths:@[@"frame"]];
    
    //Set initial value
    self.view.frame = CGRectMake(20.0f, 20.0f, 50.0f, 50.0f);
    
    //Create tween
    Tween* tween = [[Tween alloc] init:self.view//Target
                              duration:1.0f//One second
                                  ease:Ease.inOutCubic//Transition
                                  keys:@{@"frame" : [NSValue valueWithCGRect:CGRectMake(250.0f, 20.0f, 50.0f, 50.0f)],
                                         }
                    delay:1.0f//One second delay
                    ];
    
    //set initial value
    self.backgroundColor = UIColor.whiteColor;
    
    //Setup handlers
    tween.onStartHandler = ^{
        self.backgroundColor = UIColor.greenColor;
    };
    
    tween.onCompleteHandler = ^{
        self.backgroundColor = UIColor.redColor;
    };
    
    //Add tween
    [CocoaTweener addTween:tween];
}



@end
