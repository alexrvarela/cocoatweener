//
//  CurveInspector.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 2/24/19.
//  Copyright © 2019 Alejandro Ramirez Varela. All rights reserved.
//

#import "CurveInspector.h"

@implementation CurveInspector

-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = UIColor.clearColor;
        
        printf("CurveInspector init\n");
        //Label
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                               0.0f,
                                                               self.frame.size.width,
                                                               40.0f)];
        
        self.label.textColor = [UIColor blackColor];
        self.label.font = [UIFont systemFontOfSize:24.0];
        self.label.text = @"EaseType";
        [self addSubview:self.label];
        
        CGRect graphFrame = CGRectMake(0.0f, 40.0f, self.frame.size.width, self.frame.size.height - 110.0f);
        
        //Border
        self.border = [[UIView alloc] initWithFrame:graphFrame];
        self.border .userInteractionEnabled = NO;
        self.border.layer.borderColor = UIColor.blackColor.CGColor;
        self.border.layer.borderWidth = 1.0f;
        [self addSubview:self.border];
        
        
        //Curve
        self.curve = [[UIView alloc] initWithFrame:graphFrame];
        self.curve.userInteractionEnabled = NO;
        [self addSubview:self.curve];
        
        //Asset
        self.asset = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                              self.frame.size.height - 50.0f,
                                                              50.0f,
                                                              50.0f)];
        self.asset.userInteractionEnabled = NO;
        self.asset.layer.cornerRadius = 50.0f/2.0f;
        self.asset.backgroundColor = [UIColor colorWithRed:1.0 green:48.0 / 255.0 blue:130 / 255.0 alpha:1.0];
        [self addSubview:self.asset];
        
        //Line x
        self.linex = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                             graphFrame.origin.y,
                                                             1.0f,
                                                             graphFrame.size.height)];
        self.linex.userInteractionEnabled = NO;
        self.linex.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
        [self addSubview:self.linex];
        
        //Line y
        self.liney = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                              graphFrame.origin.y,
                                                              graphFrame.size.width,
                                                              1.0f)];
        self.liney.userInteractionEnabled = NO;
        self.liney.backgroundColor = [UIColor colorWithRed:0.0 green:202.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
        [self addSubview:self.liney];
        
        //Play icon
        
        //Add play action
        [self addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(void)setEase:(Equation)ease
{
    //Remove old layer
    self.curve.layer.sublayers = nil;
    
    _ease = ease;
    
    UIBezierPath* path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0.0f, self.curve.frame.size.height)];
    
    int segments = 200;
    
    double b = self.curve.frame.size.height;
    double c = 0.0 - b;
    
    for (int i = 0; i < segments; i++)
    {
        double interpolation = (1.0 / (double)segments) * (double)i;
        double x = self.curve.frame.size.width * interpolation;
        double y = _ease(interpolation, b, c, 1.0);
        [path addLineToPoint:CGPointMake(x, y)];
    }
    
    //Add end point
    [path addLineToPoint:CGPointMake(self.curve.frame.size.width, 0.0)];
    
    //add sublayer
    [self.curve.layer addSublayer:[self makeStrokedLayer:path]];
}

-(CAShapeLayer*)makeStrokedLayer:(UIBezierPath*)path
{
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = [UIColor colorWithRed:1.0 green:48.0 / 255.0 blue:130 / 255.0 alpha:1.0].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.path = path.CGPath;
    
    return shapeLayer;
}

-(void)play
{
    printf("play\n");
    //Asset
    [CocoaTweener removeTweens:self.asset];
    CGRect assetFrame = self.asset.frame;
    assetFrame.origin.x = 0.0;
    self.asset.frame = assetFrame;
    assetFrame.origin.x = self.frame.size.width - self.asset.frame.size.width;
    [CocoaTweener addTween:[[Tween alloc] init:self.asset
                                      duration:1.0f
                                          ease:self.ease
                                          keys:@{@"frame":[NSValue valueWithCGRect:assetFrame]}]
     ];
    
    //Line x
    [CocoaTweener removeTweens:self.linex];
    //Initial state
    CGRect lineFrame = self.linex.frame;
    lineFrame.origin.x = 0.0f;
    self.linex.frame = lineFrame;
    //Change
    lineFrame.origin.x = self.frame.size.width - 1.0f;
    [CocoaTweener addTween:[[Tween alloc] init:self.linex
                                      duration:1.0f
                                          ease:Ease.none
                                          keys:@{@"frame":[NSValue valueWithCGRect:lineFrame]}]
     ];
    
    //Line y
    [CocoaTweener removeTweens:self.liney];
    //Initial state
    lineFrame = self.liney.frame;
    lineFrame.origin.y = self.curve.frame.origin.y + self.curve.frame.size.height;
    self.liney.frame = lineFrame;
    //Change
    lineFrame.origin.y = self.curve.frame.origin.y;
    [CocoaTweener addTween:[[Tween alloc] init:self.liney
                                      duration:1.0f
                                          ease:self.ease
                                          keys:@{@"frame":[NSValue valueWithCGRect:lineFrame]}]
     ];
}


@end
