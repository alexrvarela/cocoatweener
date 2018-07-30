//
//  TouchPoint.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/12/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "TouchPoint.h"
#import <CocoaTweener/CocoaTweener.h>

@implementation TouchPoint

-(id)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:69.0f/255.0f green:255.0f/255.0f blue:247.0f/255 alpha:1.0f];
        [self makeAssets];
    }
    
    return self;
}

-(void)makeAssets
{
    NSArray<UIColor*>* colors = @[
                        [UIColor colorWithRed:66.0f/255.0f green:0.0f blue:162/255 alpha:1.0f],
                        [UIColor colorWithRed:129.0f/255.0f green:16.0f/255 blue:152.0f/255.0f alpha:1.0f],
                        [UIColor colorWithRed:192.0f/255.0f green:32.0f/255.0f blue:141.0f/255.0f alpha:1.0f],
                        [UIColor colorWithRed:255.0f/255.0f green:48.0f/255.0f blue:131.0f/255.0f alpha:1.0f],
                        [UIColor colorWithRed:255.0f/255.0f green:117.0f/255.0f blue:131.0f/255.0f alpha:1.0f],
                        [UIColor colorWithRed:255.0f/255.0f green:186.0f/255.0f blue:131.0f/255.0f alpha:1.0f],
                        [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:131.0f/255.0f alpha:1.0f],
                        [UIColor colorWithRed:193.0f/255.0f green:255.0f/255.0f blue:170.0f/255.0f alpha:1.0f],
                        [UIColor colorWithRed:131.0f/255.0f green:255.0f/255.0f blue:208.0f/255.0f alpha:1.0f],
                        ];
    
    for (int indexColor = 0; indexColor < colors.count; indexColor++)
    {
        UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                             0.0f,
                                                             60.0f + 80.0f * indexColor,
                                                             60.0f + 80.0f * indexColor)];
        
        v.backgroundColor = [colors objectAtIndex:indexColor];
        v.layer.cornerRadius = v.frame.size.width / 2.0f;
        v.center = self.center;
        [self insertSubview:v atIndex:0];
    }
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [[[event allTouches] allObjects] objectAtIndex:0];
    CGPoint p = [touch locationInView:self];

    int count  = (int)self.subviews.count;
    for(UIView* v in self.subviews)
    {
        [CocoaTweener removeTweens:v];//remove existing tweens
        
        Tween *tween = [[Tween alloc] init:v
                                  duration:2.0f
                                      ease:kEaseOutElastic
                                      keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSValue valueWithCGPoint:p], @"center",
                                            nil]
                                     delay:0.025f * count
                        ];
        
        [CocoaTweener addTween:tween];
        count--;
    }
    
}



@end
