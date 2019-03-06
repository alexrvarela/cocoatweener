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
        sunny.scale = 0.75f;
        sunny.frame = CGRectMake(self.center.x - sunny.frame.size.width / 2.0f,
                                 (self.center.y - sunny.frame.size.height) / 2.0f,
                                 sunny.frame.size.width,
                                 sunny.frame.size.height);
        [self addSubview:sunny];
        
        UIView* grass = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                 self.frame.size.height * 0.9f,
                                                                 self.frame.size.width,
                                                                 self.frame.size.height * 0.1f)];
        grass.backgroundColor = [UIColor colorWithRed:130.0f/255.0f green:255.0f/255.0f blue:170.0f/255 alpha:1.0f];
        [self addSubview:grass];
        
        
        UIView* stick = [[UIView alloc] initWithFrame:CGRectMake(self.center.x - 5.0f,
                                                                  self.frame.size.height - 220.0f,
                                                                  10.0f,
                                                                  220.0f)];
        
        stick.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:140.0f/255 alpha:1.0f];
        [self addSubview:stick];
        
        self.dart = [[PDFImageView alloc] init];
        [self.dart loadFromBundle:@"dart"];
        self.dart.center = CGPointMake(self.center.x, self.frame.size.height - 220.0f);
        [self addSubview:self.dart];
        
        self.rotation = [[RotationAim alloc] init];
        self.rotation.target = self.dart;
        [self animate];
    }
    
    return self;
}

-(void)animate
{
    float random = [BasicMath randomIntRange:5.0f min:1.0f];
    
    [CocoaTweener addTween:[[Tween alloc] init:self.rotation
                                      duration:random * 2.0f
                                          ease:Ease.inOutQuad
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:random], @"distance",
                                                nil]
                                         delay:0.0f
                                    completion:^{[self animate];}
                            ]];
    
}

@end
