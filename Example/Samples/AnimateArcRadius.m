//
//  AnimateArcRadius.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/22/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AnimateArcRadius.h"

@implementation AnimateArcRadius

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:65.0f/255.0f green:50.0f/255.0f blue:160.0f/255 alpha:1.0f];

        //eyeball
        self.eyeBall = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                0.0f,
                                                                180.0f,
                                                                180.0f)];
        
        self.eyeBall.backgroundColor = [UIColor colorWithRed:222.0f/255.0f green:255.0f/255.0f blue:220.0f/255 alpha:1.0f];
        self.eyeBall.center =  self.center;
        self.eyeBall.clipsToBounds = YES;
        self.eyeBall.layer.cornerRadius = 180.0f / 2.0f;
        [self addSubview:self.eyeBall];
        self.eyeBall.userInteractionEnabled = NO;
        
        CGPoint targetCenter = CGPointMake(self.eyeBall.frame.size.width / 2.0f,
                                           self.eyeBall.frame.size.height / 2.0f);
        
        //eyepupil
        self.eyePupil = [[PDFImageView alloc] init];
        [self.eyePupil loadFromBundle:@"eyepupil"];
        self.eyePupil.scale = 1.25;
        self.eyePupil.center = targetCenter;
        [self.eyeBall addSubview:self.eyePupil];
        

        //animation frames
        self.opennedTop = CGRectMake(self.eyeBall.frame.origin.x,
                                     self.eyeBall.frame.origin.y - self.eyeBall.frame.size.height / 2.0f,
                                     self.eyeBall.frame.size.width,
                                     self.eyeBall.frame.size.height / 2.0f);
        
        self.closedTop = CGRectMake(self.opennedTop.origin.x,
                                    self.opennedTop.origin.y + self.opennedTop.size.height,
                                    self.opennedTop.size.width,
                                    self.opennedTop.size.height);
        
        self.opennedBottom =CGRectMake(self.eyeBall.frame.origin.x,
                                       self.eyeBall.frame.origin.y + self.eyeBall.frame.size.height,
                                       self.eyeBall.frame.size.width,
                                       self.eyeBall.frame.size.height / 2.0f);
        
        self.closedBottom = CGRectMake(self.opennedBottom.origin.x,
                                       self.eyeBall.frame.origin.y + self.eyeBall.frame.size.height / 2.0f,
                                       self.opennedBottom.size.width,
                                       self.opennedBottom.size.height);
        
        //eyelips
        self.eyeLipTop = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                  self.eyeBall.frame.size.width,
                                                                  self.eyeBall.frame.size.height / 2.0f)];
        
        self.eyeLipTop.frame = self.opennedTop;
        self.eyeLipTop.backgroundColor = self.backgroundColor;
        [self addSubview:self.eyeLipTop];
        
        self.eyeLipBottom  = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                      self.eyeBall.frame.size.width,
                                                                      self.eyeBall.frame.size.height / 2.0f)];
        self.eyeLipBottom.frame = self.opennedBottom;
        self.eyeLipBottom.backgroundColor = self.backgroundColor;
        [self addSubview:self.eyeLipBottom];

        //aim
        self.aim = [[ArcAim alloc] init];
        self.aim.target = self.eyePupil;
        self.aim.radius = 0.0f;
        self.aim.center = targetCenter;
        
        [self sleepEye];
    }
    
    return self;
}

-(void)openEye
{
    self.isClosed = NO;
    [self animateLips:self.opennedTop bottom:self.opennedBottom];
}

-(void)sleepEye
{
    self.isClosed = NO;
    [self animateLips:self.closedTop bottom:self.opennedBottom];
}

-(void)closeEye
{
    printf("close eye\n");
    self.isClosed = YES;
   [self animateLips:self.closedTop bottom:self.closedBottom];
}


-(void)animateRadius:(float)radius
{
    printf("\nanimate radius\n");
    [CocoaTweener removeTweens:self.aim];
    [CocoaTweener addTween:[[Tween alloc] init:self.aim
                                      duration:0.1f
                                          ease:kEaseOutQuad
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:radius], @"radius",
                                                nil]
                                         delay:0.0f
                            ]];
}

-(void)animateLips:(CGRect)topFrame bottom:(CGRect)bottomFrame
{
    
    printf("\nanimate top lip\n");
    [CocoaTweener removeTweens:self.eyeLipTop];
    [CocoaTweener addTween:[[Tween alloc] init:self.eyeLipTop
                                      duration:0.1f
                                          ease:kEaseOutQuad
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSValue valueWithCGRect: topFrame], @"frame",
                                                nil]
                                         delay:0.0f
                            ]];
    
    printf("\nanimate bottom lip\n");
    [CocoaTweener removeTweens:self.eyeLipBottom];
    [CocoaTweener addTween:[[Tween alloc] init:self.eyeLipBottom
                                      duration:0.1f
                                          ease:kEaseOutQuad
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSValue valueWithCGRect:bottomFrame], @"frame",
                                                nil]
                                         delay:0.0f
                            ]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [[event allTouches] anyObject];
    
    
    CGFloat distance = [BasicMath length:[touch locationInView:self]
                                   end:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
//    float distance = lenght([touch locationInView:self], CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f));
    
    if (distance < self.eyeBall.frame.size.width / 2.0f)
    {
        if (!self.isClosed)
        {
            [self closeEye];
        }
    }
    else
    {
        [self animateRadius:self.eyeBall.frame.size.width / 2.0];
        self.aim.arcPoint = [touch locationInView:self.eyeBall];
        [self openEye];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [[event allTouches] anyObject];

    CGFloat distance = [BasicMath length:[touch locationInView:self] end:CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
    
    if (distance < self.eyeBall.frame.size.width / 2.0f)
    {
        if (!self.isClosed)
        {
            if (self.aim.radius != 0.0)
            {
                [self animateRadius:0.0];
            }
            
            [self closeEye];
        }
    }
    else
    {
        if (self.aim.radius == 0.0)
        {
            [self animateRadius:self.eyeBall.frame.size.width / 2.0];
        }
        
        self.aim.arcPoint = [touch locationInView:self.eyeBall];
        
        if (self.isClosed)
        {
            [self openEye];
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isClosed)
    {
        [self openEye];
    }

    [self delaySleep];
    [self animateRadius:0.0];
}

-(void)delaySleep
{
    printf("\ntop lip delay sleep\n");
    [CocoaTweener addTween:[[Tween alloc] init:self.eyeLipTop
                                      duration:0.25f
                                          ease:kEaseOutQuad
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSValue valueWithCGRect: self.closedTop], @"frame",
                                                nil]
                                         delay:1.0f
                            ]];
}

@end
