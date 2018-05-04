//
//  TimelineBasic.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/12/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#pragma mark - Math
#define DEGREES_TO_RADIANS(__DEGREE__) ((__DEGREE__) * M_PI / 180.0)
#define RADIANS_TO_DEGREES(__RADIAN__) ((__RADIAN__) * 180 / M_PI)

static inline CGPoint CalculateRotation(float angle, float radius)
{
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    
    return CGPointMake(x, y);
}

#pragma mark - CGPath

static inline CGPathRef makePolygon(int divisions, float radius, CGPoint origin)
{
    if (divisions < 3)divisions = 3;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    float fragment = 360.0f / (float)divisions;
    
    for (int indexDivision = 0; indexDivision < divisions; indexDivision++)
    {
        CGPoint point = CalculateRotation(DEGREES_TO_RADIANS(fragment * indexDivision), radius);
        
        if (indexDivision == 0)
            CGPathMoveToPoint(path, NULL, origin.x + point.x, origin.y + point.y);
        else
            CGPathAddLineToPoint(path, NULL, origin.x + point.x, origin.y + point.y);
    }
    
    CGPathCloseSubpath(path);
    
    return path;
}

#import "TimelineBasic.h"

@implementation TimelineBasic

-(id)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:116.0f / 255.0f
                                               green:244.0f / 255.0f
                                                blue:234.0f / 255.0f
                                               alpha:1.0f];//[UIColor lightGrayColor];
        [self makeInstances];
    }
    
    return self;
}

-(void)makeInstances
{

    //---- Shape 1 ----
    self.asset1 = [[AssetSample alloc] initWithFrame:CGRectMake(0.0f, 20.0f + 75.0f, 50.0f, 50.0f)];
    self.asset1.backgroundColor = [UIColor whiteColor];
    
    CAShapeLayer*polyShape = [[CAShapeLayer alloc] init];
    polyShape.path = makePolygon(5, 25.0f, CGPointMake(25.0f, 25.0f));
    
    self.asset1.layer.mask = polyShape;
    [self addSubview:self.asset1];
    
    //---- Shape 2 ----
    self.asset2 = [[AssetSample alloc] initWithFrame:CGRectMake(0.0f, 20.0f + 75.0f * 2, 50.0f, 50.0f)];
    self.asset2.backgroundColor = [UIColor whiteColor];
    
    [self.asset2.layer setCornerRadius:25.0f];//make circle
    
    [self addSubview:self.asset2];
    
    //---- Shape 3 ----
    self.asset3 = [[AssetSample alloc] initWithFrame:CGRectMake(0.0f, 20.0f + 75.0f * 3, 50.0f, 50.0f)];
    self.asset3.backgroundColor = [UIColor whiteColor];
    
    CAShapeLayer* triangleShape = [[CAShapeLayer alloc] init];
    triangleShape.path = makePolygon(3, 25.0f, CGPointMake(25.0f, 25.0f));
    
    self.asset3.layer.mask = triangleShape;//*/
    
    self.asset3.specialProperty = 0.0f;
    [self addSubview:self.asset3];
    
    //---- Shape 4 ----
    self.asset4 = [[AssetSample alloc] initWithFrame:CGRectMake(0.0f, 20.0f + 75.0f * 4, 50.0f, 50.0f)];
    self.asset4.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.asset4];

    //TIMELINE
    self.timeline = [[Timeline alloc] init];
    
    //TWEEN 1
    CGRect newFrame = self.asset1.frame;
    newFrame.origin.x = self.bounds.size.width - self.asset1.frame.size.width;
    
    NSDictionary *keys = @{
                           @"frame" : [NSValue valueWithCGRect:newFrame],
                           @"alpha" : [NSNumber numberWithFloat:0.25f]
                           };
    
    Tween* tween = [[Tween alloc] init:self.asset1
                              duration:1.0
                                  ease:kEaseOutQuad
                                  keys:keys
                    ];
    
    [self.timeline addTween:tween];
    
    //*/
    
    //TWEEN 2
    
    //set inital value
    newFrame = self.asset2.frame;
    
    //set start value
    newFrame.origin.x = self.bounds.size.width - self.asset2.frame.size.width;
    
    //set property names and values
    keys = @{
             @"frame":[NSValue valueWithCGRect:newFrame],//Add key with destination value
             };
    
    //Make tween parameters for each target
    tween = [[Tween alloc] init:self.asset2
                       duration:1.0
                           ease:kEaseInOutBounce
                           keys:keys
             ];
    
    //add tween to timeline, pass target, parameters and key paths
    [self.timeline addTween:tween];
    
    //TWEEN 3
    
    tween = [[Tween alloc] init:self.asset3
                       duration:1.0
                           ease:kEaseOutQuad
                           keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithFloat:1.0f], @"rotationAngle",
                                 nil]
             ];
    
    [self.timeline addTween:tween];
    
    
    newFrame = CGRectMake(self.asset4.frame.origin.x,
                          self.asset4.frame.origin.y,
                          100.0f,
                          100.0f);

    //Tween 4
    tween = [[Tween alloc] init:self.asset4
                              duration:1.0
                                  ease:kEaseOutElastic
                                  keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSValue valueWithCGRect:newFrame], @"frame",
                                        nil]
                    ];

    [self.timeline addTween:tween];
    
    TimelineViewer* inspector = [[TimelineViewer alloc] init];
    inspector.timeline = self.timeline;
    [self addSubview:inspector];
}




@end
