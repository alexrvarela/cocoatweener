//
//  PathLoop.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/17/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "PathLoop.h"

@implementation PathLoop

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:130.0f/255.0f green:255.0f/255.0f blue:170.0f/255 alpha:1.0f];
        
        //flower
        self.flower = [[PDFImageView alloc] init];
        [self.flower loadFromBundle:@"flower"];
        self.flower.frame = CGRectMake(self.center.x - self.flower.frame.size.width / 2.0f,
                                 self.frame.size.height - self.flower.frame.size.height,
                                 self.flower.frame.size.width,
                                 self.flower.frame.size.height);
        
        [self addSubview:self.flower];
        
        //bee
        self.bee = [[PDFImageView alloc] init];
        [self.bee loadFromBundle:@"bee"];
        self.bee.scale = 1.5f;
        self.bee.center = self.center;
        [self addSubview:self.bee];
        
        //Bezier path
        UIBezierPath* myPath = [[UIBezierPath alloc] init];
        CGPoint translate = self.center;
        [myPath moveToPoint:CGPointMake(translate.x + 40.088, translate.y + 40.088)];
        [myPath addCurveToPoint:CGPointMake(translate.x + 120.2639, translate.y + 40.088) controlPoint1:CGPointMake(translate.x + 62.2279 , translate.y + 62.2279) controlPoint2:CGPointMake(translate.x + 98.1239 , translate.y + 62.2279)];
        [myPath addCurveToPoint:CGPointMake(translate.x + 120.2639, translate.y -40.0879) controlPoint1:CGPointMake(translate.x + 142.4038 , translate.y + 17.9481) controlPoint2:CGPointMake(translate.x + 142.4038 , translate.y -17.948)];
        [myPath addCurveToPoint:CGPointMake(translate.x + 40.088, translate.y -40.088) controlPoint1:CGPointMake(translate.x + 98.1239 , translate.y -62.2279) controlPoint2:CGPointMake(translate.x + 62.2279 , translate.y -62.2279)];
        [myPath addLineToPoint:CGPointMake(translate.x -40.088, translate.y + 40.088)];
        [myPath addCurveToPoint:CGPointMake(translate.x -120.2639, translate.y + 40.088) controlPoint1:CGPointMake(translate.x -62.2279 , translate.y + 62.2279) controlPoint2:CGPointMake(translate.x -98.1239 , translate.y + 62.2279)];
        [myPath addCurveToPoint:CGPointMake(translate.x -120.2639, translate.y -40.0879) controlPoint1:CGPointMake(translate.x -142.4038 , translate.y + 17.9481) controlPoint2:CGPointMake(translate.x -142.4038 , translate.y -17.948)];
        [myPath addCurveToPoint:CGPointMake(translate.x -40.088, translate.y -40.088) controlPoint1:CGPointMake(translate.x -98.1239 , translate.y -62.2279) controlPoint2:CGPointMake(translate.x -62.2279 , translate.y -62.2279)];
        [myPath addLineToPoint:CGPointMake(translate.x + 40.088, translate.y + 40.088)];
        
        //Path interpolator
        self.tweenPath = [[PathAim alloc] init];
        self.tweenPath.path = myPath;
        self.tweenPath.target = self.bee;
        self.tweenPath.orientToPath = YES;
        
        self.pathView = [[UIView alloc] initWithFrame:self.bounds];
        self.pathView.userInteractionEnabled = NO;
        self.pathView.hidden = YES;
        [self addSubview:self.pathView];
        [self drawPath];
        
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                               self.center.y - 60.0f,
                                                               self.frame.size.width - 40.0f,
                                                               60.0f)];

        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:22.0];
        self.label.text = @"Tap to show path" ;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.center = CGPointMake(self.frame.size.width / 2.0f,
                                        self.center.y - self.frame.size.height * 0.25f);
        [self addSubview:self.label];
        
        UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(tap:)];
        [self addGestureRecognizer:tapRecognizer];
        
        //TODO:enable handlers
        
        //play
        [self play];
    }
 
    return self;
}

-(void)play
{
    self.tweenPath.interpolation = 0.0;
    
    [CocoaTweener addTween:[[Tween alloc] init:self.tweenPath
                                      duration:2.0f
                                          ease:Ease.none
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:1.0f], @"interpolation",
                                                nil]
                                         delay:0.0
                                    completion:^{
                                             [self play];//loop
                                         }
                            ]
     ];
}

-(void)tap:(UITapGestureRecognizer *)sender
{
    //show/hide path layer
    self.pathView.hidden = !self.pathView.hidden;
    self.label.text = self.pathView.hidden ? @"Tap to show path" : @"Tap to hide path";
}

-(void)drawPath
{
    [self.pathView.layer addSublayer:[self makeStrokedLayer:self.tweenPath.path]];
    
    //draw points
    for (NSArray* points in self.tweenPath.points)
    {
        NSValue* value = [points lastObject];
        CGPoint origin = value.CGPointValue;
        [self.pathView.layer addSublayer:[self makeFillLayer:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(origin.x - 4.0f, origin.y - 4.0f, 8.0f, 8.0f) cornerRadius:2.0f]]];
    }
}

-(CAShapeLayer*)makeFillLayer:(UIBezierPath*)path
{
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];

    shapeLayer.fillColor = UIColor.whiteColor.CGColor;
    shapeLayer.path = path.CGPath;
    
    return shapeLayer;
}

-(CAShapeLayer*)makeStrokedLayer:(UIBezierPath*)path
{
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = UIColor.whiteColor.CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.path = path.CGPath;
    
    return shapeLayer;
}

@end
