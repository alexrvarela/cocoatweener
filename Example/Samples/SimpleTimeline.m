//
//  SimpleTimeline.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 9/5/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "SimpleTimeline.h"

@implementation SimpleTimeline

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:65.0f/255.0f blue:80.0f/255 alpha:1.0f];
        
        //Create asset
        self.circle = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width -  200.0f) / 2.0f,
                                                               20.0f,
                                                               200.0f,
                                                               200.0f)];
        self.circle.layer.cornerRadius = 200.0f / 2.0f;
        self.circle.backgroundColor = [UIColor colorWithRed:80.0f/255.0f green:220.0f/255.0f blue:170.0f/255 alpha:1.0f];
        [self addSubview:self.circle];
        

        self.timeline = [[Timeline alloc] init];
        [self.timeline addTween:[[Tween alloc] init:self.circle
                                           duration:1.5f
                                               ease:kEaseOutBounce
                                               keys:@{@"frame" : [NSValue valueWithCGRect:CGRectMake(self.circle.frame.origin.x,
                                                                                                     self.frame.size.height -self.circle.frame.size.height - 20.0f,
                                                                                                     self.circle.frame.size.width,
                                                                                                     self.circle.frame.size.height)]                                                     }
                                 ]
         ];
        self.timeline.playMode = kTimelinePlayModeLoop;
        [self.timeline play];
        
        //Gesture recognizer
        UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(tap:)];
        [self addGestureRecognizer:tapRecognizer];

    }
    return self;
}

-(void)tap:(UITapGestureRecognizer *)sender
{
    //Change playmode
    if (self.timeline.playMode == kTimelinePlayModeLoop)
    {
        self.timeline.playMode = kTimelinePlayModePingPong;
    }else
    {
        self.timeline.playMode = kTimelinePlayModeLoop;
        self.timeline.reverse = false;
    }
}



@end
