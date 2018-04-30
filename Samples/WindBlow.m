//
//  WindBlow.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/13/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "WindBlow.h"
#import "CocoaTweener.h"
#import "Math.h"

@implementation WindBlow

-(id)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
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
                                                                 self.frame.size.height * 0.75f,
                                                                 self.frame.size.width,
                                                                 self.frame.size.height * 0.25f)];
        grass.backgroundColor = [UIColor colorWithRed:130.0f/255.0f green:255.0f/255.0f blue:170.0f/255 alpha:1.0f];
        [self addSubview:grass];
        
        
        UIView* b = [[UIView alloc] initWithFrame:CGRectMake(self.center.x - 5.0f,
                                                             self.frame.size.height - 280.0f,
                                                             10.0f,
                                                             280.0f)];
        
        b.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:140.0f/255 alpha:1.0f];
        [self addSubview:b];
        
        self.asset = [[PDFImageView alloc] init];
        [self.asset loadFromBundle:@"dart"];
         CGPoint c = self.center;
        c.y = self.frame.size.height - 280.0f;
        self.asset.center = c;
        [self addSubview:self.asset];

        
        self.blow = 0.0f;
        [self animate];
    }
    
    return self;
}

-(void)setBlow:(float)interpolation
{
    float multiplier = 360.0f;
    float degree = (interpolation - floor(interpolation)) * multiplier;
    self.asset.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.0);
    _blow = interpolation;
}

-(void)animate
{
    float random = GetRandomFloatRange(5.0f, 1.0f);
    
    [CocoaTweener addTween:[[Tween alloc] init:self
                                      duration:random * 2.0f
                                          ease:kEaseInOutQuad
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:random], @"blow",//TODO: set random
                                                nil]
                                         delay:0.0f
                                    completion:^{[self animate];}
                            ]];
}

@end
