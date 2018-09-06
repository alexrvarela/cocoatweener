//
//  DragView.m
//  Examples
//
//  Created by Alejandro Ramirez on 9/5/18.
//  Copyright © 2018 Alejandro Ramirez. All rights reserved.
//

#import "DragView.h"
#import <CocoaTweener/CocoaTweener.h>

@implementation DragView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:65.0f/255.0f blue:80.0f/255 alpha:1.0f];
        
        //Set color list
        NSArray<UIColor*>* colors = @[[UIColor colorWithRed:255.0f/255.0f green:120.0f/255.0f blue:180.0f/255 alpha:1.0f],
                                      [UIColor colorWithRed:80.0f/255.0f green:220.0f/255.0f blue:170.0f/255 alpha:1.0f],
                                      [UIColor colorWithRed:110.0f/255.0f green:100.0f/255.0f blue:240.0f/255 alpha:1.0f]];
        
        //Create assets
        for (NSUInteger i = colors.count; i > 0; i--)
        {
            NSUInteger index = i - 1;
            PDFImageView* view = [[PDFImageView alloc] init];
            [view loadFromBundle:@"card"];
            view.scale = (self.frame.size.width - 40.0f) / view.frame.size.width;
            view.frame = CGRectMake(20.0f, 20.0f + (view.frame.size.height + 20.0f) * index, view.frame.size.width, view.frame.size.height);
            view.backgroundColor = [colors objectAtIndex:index];
            view.layer.cornerRadius = 10.0f;
            [self addSubview:view];
        }
        
        //Add pan gesture recognizer
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(pan:)];
        panRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:panRecognizer];
    }
    return self;
}

-(void)pan:(UIPanGestureRecognizer*)recognizer
{
    CGPoint p = CGPointZero;
    CGPoint translation = [recognizer translationInView:self];
    
    if(recognizer.numberOfTouches > 0) p = [recognizer locationOfTouch:0 inView:self];
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        for (UIView* view in self.subviews)
        {
            if (CGRectContainsPoint(view.frame, p))
            {
                self.dragView = view;
                self.viewIndex = [self.subviews indexOfObject:view];
                self.frameOrigin = view.frame.origin;
                break;
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        if (self.dragView != nil)
        {
            self.dragView.frame = CGRectMake(self.frameOrigin.x + translation.x,
                                             self.frameOrigin.y + translation.y,
                                             self.dragView.frame.size.width,
                                             self.dragView.frame.size.height);
            
            NSUInteger currentIndex = self.viewIndex;
            NSUInteger index = self.subviews.count - 1;
            
            for (NSUInteger i = 0; i < self.subviews.count; i++)
            {
                float _y = 20.0f + (self.dragView.frame.size.height + 20.0f) * i + self.dragView.frame.size.height;
                
                if (self.dragView.frame.origin.y < _y)
                {
                    currentIndex = index;
                    break;
                }
                
                index--;
            }
            
            if (currentIndex != self.viewIndex)
            {
                //Swap
                self.viewIndex = currentIndex;
                [self insertSubview:self.dragView atIndex:currentIndex];
                [self alingViews];
            }
        }
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded ||
              recognizer.state == UIGestureRecognizerStateCancelled)
    {
        self.dragView = nil;
        [self alingViews];
    }
}

-(void)alingViews
{
    NSUInteger index = self.subviews.count - 1;
    
    for (UIView* view in self.subviews)
    {
        if (self.dragView == nil || self.viewIndex != [self.subviews indexOfObject:view])
        {
            [CocoaTweener removeTweens:view];
            NSValue* destinationFrame = [NSValue valueWithCGRect:CGRectMake(20.0f,
                                                                            20.0f + (view.frame.size.height + 20.0f) * index,
                                                                            view.frame.size.width,
                                                                            view.frame.size.height)];
            [CocoaTweener addTween:[[Tween alloc] init:view
                                              duration:0.25f
                                                  ease:kEaseOutQuad
                                                  keys:@{@"frame" : destinationFrame}]];
        }
        
        index --;
    }
}

@end
