//
//  WindBlow.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/13/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//


//static inline float GetRandomFloatRange(float Maxvalue, float MinValue)
//{
//    return ((float)arc4random() % (Maxvalue - MinValue)) + MinValue;
//}

#import "WindBlow.h"

@implementation WindBlow

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:222.0f/255.0f green:255.0f/255.0f blue:220.0f/255 alpha:1.0f];

        PDFImageView* sunny = [[PDFImageView alloc] init];
        [sunny loadFromBundle:@"sunny"];
        sunny.frame = CGRectMake(self.center.x - sunny.frame.size.width / 2.0f,
                                 (self.center.y - sunny.frame.size.height) / 2.0f,
                                 sunny.frame.size.width,
                                 sunny.frame.size.height);
        [self addSubview:sunny];
        
        UIView* grass = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                 self.frame.size.height * 0.85f,
                                                                 self.frame.size.width,
                                                                 self.frame.size.height * 0.15f)];
        grass.backgroundColor = [UIColor colorWithRed:130.0f/255.0f green:255.0f/255.0f blue:170.0f/255 alpha:1.0f];
        [self addSubview:grass];
        
        
        UIView* b = [[UIView alloc] initWithFrame:CGRectMake(self.center.x - 5.0f,
                                                             self.frame.size.height - 280.0f,
                                                             10.0f,
                                                             280.0f)];
        
        b.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:140.0f/255 alpha:1.0f];
        [self addSubview:b];

        self.dart1 = [[PDFImageView alloc] init];
        [self.dart1 loadFromBundle:@"dart"];
        self.dart1.scale = 0.25f;
        self.dart1.center = CGPointMake(self.frame.size.width * 0.75, self.frame.size.height - 120.0f);
        [self addSubview:self.dart1];
        
        self.dart2 = [[PDFImageView alloc] init];
        [self.dart2 loadFromBundle:@"dart"];
        self.dart2.scale = 0.5f;
        self.dart2.center = CGPointMake(self.center.x * 0.5, self.frame.size.height - 150.0f);
        [self addSubview:self.dart2];
        
        self.dart3 = [[PDFImageView alloc] init];
        [self.dart3 loadFromBundle:@"dart"];
        self.dart3.center = CGPointMake(self.center.x, self.frame.size.height - 280.0f);
        [self addSubview:self.dart3];
        
        self.blow = 0.0f;
        
        self.rotation = [[RotationAim alloc] init];
        
        __weak typeof(self) weakself = self;
        self.rotation.onUpdateRotation = ^(CGFloat rotation)
        {
            weakself.dart1.transform = CGAffineTransformMakeRotation(rotation);
            weakself.dart2.transform = CGAffineTransformMakeRotation(rotation);
            weakself.dart3.transform = CGAffineTransformMakeRotation(rotation);
        };
        
        [self animate];
    }
    
    return self;
}

-(void)animate
{
    float random = [BasicMath randomIntRange:5.0f min:1.0f];
    
    [CocoaTweener addTween:[[Tween alloc] init:self.rotation
                                      duration:random * 2.0f
                                          ease:kEaseInOutQuad
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:random], @"distance",
                                                nil]
                                         delay:0.0f
                                    completion:^{[self animate];}
                            ]];
    
}

@end
