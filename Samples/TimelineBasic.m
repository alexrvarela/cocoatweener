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
        self.backgroundColor = [UIColor lightGrayColor];
        [self makeInstances];
    }
    
    return self;
}

-(void)makeInstances
{
    //---- Shape 1 ----
    self.asset1 = [[AssetSample alloc] initWithFrame:CGRectMake(75.0f, 75.0f, 50.0f, 50.0f)];
    self.asset1.backgroundColor = [UIColor magentaColor];
    
    CAShapeLayer*polyShape = [[CAShapeLayer alloc] init];
    polyShape.path = makePolygon(5, 25.0f, CGPointMake(25.0f, 25.0f));
    
    self.asset1.layer.mask = polyShape;
    [self addSubview:self.asset1];
    
    //---- Shape 2 ----
    self.asset2 = [[AssetSample alloc] initWithFrame:CGRectMake(75.0f, 75.0f * 2, 50.0f, 50.0f)];
    self.asset2.backgroundColor = [UIColor yellowColor];
    
    [self.asset2.layer setCornerRadius:25.0f];//make circle
    
    [self addSubview:self.asset2];
    
    //---- Shape 3 ----
    self.asset3 = [[AssetSample alloc] initWithFrame:CGRectMake(75.0f, 75.0f * 3, 50.0f, 50.0f)];
    self.asset3.backgroundColor = [UIColor greenColor];
    
    CAShapeLayer* triangleShape = [[CAShapeLayer alloc] init];
    triangleShape.path = makePolygon(3, 25.0f, CGPointMake(25.0f, 25.0f));
    
    self.asset3.layer.mask = triangleShape;//*/
    
    //asset3.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    
    self.asset3.specialProperty = 0.0f;
    [self addSubview:self.asset3];
    
    //---- Shape 4 ----
    self.asset4 = [[AssetSample alloc] initWithFrame:CGRectMake(75.0f, 75.0f * 4, 50.0f, 50.0f)];
    self.asset4.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.asset4];
    
    //Button1
    UIButton* playButton1 = [self makePlayButton];
    [playButton1 addTarget:self action:@selector(tween1) forControlEvents:UIControlEventTouchUpInside];
    playButton1.frame = CGRectMake(10.0f,
                                   75.0f,
                                   playButton1.frame.size.width,
                                   playButton1.frame.size.height);
    [self addSubview:playButton1];
    
    //Button2
    UIButton* playButton2 = [self makePlayButton];
    [playButton2 addTarget:self action:@selector(tween2) forControlEvents:UIControlEventTouchUpInside];
    playButton2.frame = CGRectMake(10.0f,
                                   75.0f * 2,
                                   playButton1.frame.size.width,
                                   playButton1.frame.size.height);
    
    [self addSubview:playButton2];
    
    //Button3
    UIButton* playButton3 = [self makePlayButton];
    [playButton3 addTarget:self action:@selector(tween3) forControlEvents:UIControlEventTouchUpInside];
    playButton3.frame = CGRectMake(10.0f,
                                   75.0f * 3,
                                   playButton3.frame.size.width,
                                   playButton3.frame.size.height);
    
    [self addSubview:playButton3];
    
    //Button4
    UIButton* playButton4 = [self makePlayButton];
    [playButton4 addTarget:self action:@selector(tween4) forControlEvents:UIControlEventTouchUpInside];
    playButton4.frame = CGRectMake(10.0f,
                                   75.0f * 4,
                                   playButton4.frame.size.width,
                                   playButton4.frame.size.height);
    
    [self addSubview:playButton4];
    
    
    [self makeTimeline];
    
    TimelineViewer* inspector = [[TimelineViewer alloc] initWithFrame:CGRectMake(0.0f,
                                                                                 self.frame.size.height - (60.0f + 25.0f * 4),
                                                                                 self.frame.size.height,
                                                                                 60.0f + 25.0f * 4)];
    inspector.timeline = self.timeline;
    [self addSubview:inspector];
}

-(void)makeTimeline
{
    //**** INSTANTIATE TIMELINE ****
    printf("make timeline\n");
    self.timeline = [[Timeline alloc] init];
    //self.timeline.playMode = kTimelinePlayModeLoop;
    //self.timeline.playMode = kTimelinePlayModePingPong;
    //self.timeline.reverse = YES;
    
    //TWEEN 1
    CGRect initialFrame =  self.asset1.frame;
    initialFrame.origin.x = 75.0f;
    
    //set start values
    self.asset1.frame = initialFrame;
    
    CGRect newFrame = initialFrame;
    newFrame.origin.x = self.bounds.size.width - self.asset1.frame.size.width;
    
    NSDictionary *keys = @{
                           @"frame" : [NSValue valueWithCGRect:newFrame],
                           };
    
    Tween* tween = [[Tween alloc] init:self.asset1
                              duration:1.0
                                  ease:kEaseOutQuad
                                  keys:keys
                    ];
    
    //tween.onStartHandler = ^{self.asset1.frame = initialFrame;};
    //tween.onCompleteHandler = ^{[self onCompleteExample];};
    
    //Add tween to timeline
    [self.timeline addTween:tween];
    
    //*/
    
    //TWEEN 2
    
    //set inital value
    initialFrame = self.asset2.frame;
    newFrame = initialFrame;
    
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
                          delay:1.0
             ];

    //add tween to timeline, pass target, parameters and key paths
    [self.timeline addTween:tween];
    
    //TWEEN 3
    
    tween = [[Tween alloc] init:self.asset3
                              duration:2.0
                                  ease:kEaseOutQuad
                                  keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithFloat:1.0f], @"rotationAngle",
                                        [UIColor colorWithRed:1.0f green:1.0f blue:0.5f alpha:1.0f], @"backgroundColor",
                                        nil]
                    ];
    
    [self.timeline addTween:tween];
    
    //Tween 4
    self.asset4.layer.cornerRadius = 0.0f;
    
    tween = [[Tween alloc] init:self.asset4.layer
                       duration:1
                           ease:kEaseNone
                           keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithFloat:20.0f], @"cornerRadius",
                                 nil]
             ];
    
    [self.timeline addTween:tween];
    
}


-(void)playTimeline
{
    printf("play timeline\n");
    [self.timeline play];
}

#pragma mark - Tweens
-(void)tween1
{
    [CocoaTweener removeTweens:self.asset1];
    
    //reset values without remove existing tweens
    /*
    self.asset1.backgroundColor = [UIColor whiteColor];
    
    
    //new Tween
    CGRect newFrame = CGRectMake(self.bounds.size.width - self.asset1.frame.size.width,
                                 self.asset1.frame.origin.y,
                                 self.asset1.frame.size.width,
                                 self.asset1.frame.size.height);
    
    NSDictionary *keys = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSValue valueWithCGRect:newFrame], @"frame",
                          [UIColor colorWithRed:0.0f green:1.0f blue:0.5f alpha:1.0f], @"backgroundColor",
                          nil];
    
    Tween *tween = [[Tween alloc] init:self.asset1
                              duration:1.0
                                  ease:kEaseInOutBounce
                                  keys:keys
                    ];
    
    tween.onStartHandler = ^{[self onStartExample];};
    tween.onUpdateHandler = ^{[self onUpdateExample];};
    tween.onCompleteHandler = ^{[self onCompleteExample];};
    //*/
    
    //set start position
    self.asset1.frame = CGRectMake(self.bounds.size.width - self.asset1.frame.size.width,
                                 self.asset1.frame.origin.y,
                                 self.asset1.frame.size.width,
                                 self.asset1.frame.size.height);
    
    [CocoaTweener addTween:[self.timeline.controllerList objectAtIndex:0].tween];
}

-(void)tween2
{
    //removing existing tweens
    [CocoaTweener removeTweens:self.asset2];
    
    //reset values
    self.asset2.backgroundColor = [UIColor yellowColor];
    self.asset2.frame = CGRectMake(75.0f,
                                   self.asset2.frame.origin.y,
                                   self.asset2.frame.size.width,
                                   self.asset2.frame.size.height);
    
    //TODO: inset
    CGRect newFrame = CGRectMake(self.bounds.size.width - self.asset2.frame.size.width,
                                 self.asset2.frame.origin.y,
                                 self.asset2.frame.size.width,
                                 self.asset2.frame.size.height);
    
    NSMutableDictionary *keys = [[NSMutableDictionary dictionary] init];
    [keys setObject:[NSValue valueWithCGRect:newFrame] forKey:@"frame"];
    [keys setObject:[UIColor colorWithRed:0.5f green:1.0f blue:0.0f alpha:1.0f] forKey:@"backgroundColor"];
    
    Tween *tween = [[Tween alloc] init:self.asset2
                              duration:1.0f
                                  ease:kEaseOutBounce
                                  keys:keys
                                 delay:1.00f
                            completion:^{
                                [self onCompleteExample];
                            }
                    ];
    
    [CocoaTweener addTween:tween];
}

-(void)tween3
{
    //removing existing tweens
    
    [CocoaTweener removeTweens:self.asset3];//Empty tweens
    self.asset3.rotationAngle = 0.0f;//Reset angle
    self.asset3.transform = CGAffineTransformIdentity;//Reset transformation matrix
    
    self.asset3.backgroundColor = [UIColor blackColor];
    
    //set initial state
    self.asset3.frame = CGRectMake(75.0f,
                                   self.asset3.frame.origin.y,
                                   self.asset3.frame.size.width,
                                   self.asset3.frame.size.height);
    
    Tween *tween = [[Tween alloc] init:self.asset3
                              duration:0.75
                                  ease:kEaseOutQuad
                                  keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithFloat:1.0f], @"rotationAngle",
                                        [UIColor colorWithRed:1.0f green:1.0f blue:0.5f alpha:1.0f], @"backgroundColor",
                                        nil]
                    ];
    
    tween.onStartHandler =^{self.asset3.rotationAngle = 0.0f;};
    //tween.onUpdateHandler =^{[self.asset3 onUpdateExample];};
    
    [CocoaTweener addTween:tween];
}

-(void)tween4
{
    self.asset4.specialProperty = 0.0f;
    self.asset4.backgroundColor = [UIColor purpleColor];
    
    self.asset4.frame = CGRectMake(75.0f,
                                   self.asset4.frame.origin.y,
                                   self.asset4.frame.size.width,
                                   self.asset4.frame.size.height);
    
    CGRect newFrame;
    float nRadius = self.asset4.layer.cornerRadius;
    
    if (self.asset4.frame.size.width + self.asset4.frame.size.height / 2 < 100.0f)
    {
        newFrame = CGRectMake(self.asset4.frame.origin.x,
                              self.asset4.frame.origin.y,
                              100.0f,
                              100.0f);
        nRadius = 20.0f;
    }else
    {
        newFrame = CGRectMake(self.asset4.frame.origin.x,
                              self.asset4.frame.origin.y,
                              50.0f,
                              50.0f);
        nRadius = 5.0f;
    }
    
    NSDictionary *keys = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSValue valueWithCGRect:newFrame], @"frame",
                          nil];
    
    Tween *tween = [[Tween alloc] init:self.asset4
                              duration:0.75
                                  ease:kEaseOutBack
                                  keys:keys
                    ];
    
    tween.overwrite = YES;
    [CocoaTweener addTween:tween];
    
    
    [CocoaTweener addTween:[[Tween alloc] init:self.asset4.layer
                                      duration:0.25
                                          ease:kEaseNone
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:nRadius], @"cornerRadius",
                                                nil]
                            ]];
}

#pragma mark - Events

-(void)onStartExample
{
    printf("on start example!\n");
    self.asset1.backgroundColor = [UIColor purpleColor];
    self.asset1.backgroundColor = [UIColor cyanColor];
    self.asset2.backgroundColor = [UIColor blueColor];
    self.asset3.backgroundColor = [UIColor greenColor];
    self.asset4.backgroundColor = [UIColor magentaColor];
}

-(void)onUpdateExample
{
    //stuff here
    printf("on update example!\n");
}

-(void)onCompleteExample
{
    printf("on complete example!\n");
    self.asset1.backgroundColor = [UIColor magentaColor];
    self.asset2.backgroundColor = [UIColor greenColor];
    self.asset3.backgroundColor = [UIColor blueColor];
    self.asset4.backgroundColor = [UIColor magentaColor];
}

#pragma mark - UIButton

-(UIButton*)makePlayButton
{
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.25f];
    
    CAShapeLayer*shape = [[CAShapeLayer alloc] init];
    shape.fillColor = [UIColor whiteColor].CGColor;
    shape.path = makePolygon(3, 15.0f, CGPointMake(25.0f, 25.0f));
    
    [button.layer addSublayer:shape];
    button.layer.cornerRadius = 3.5f;
    button.clipsToBounds = YES;
    
    return button;
}

@end
