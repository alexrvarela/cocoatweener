//
//  CustomEase.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 2/24/19.
//  Copyright © 2019 Alejandro Ramirez Varela. All rights reserved.
//

#import "CustomEase.h"
#import <CocoaTweener/CocoaTweener.h>

//Step 1 Interface
@interface Ease (NameYourCategory)
//Declare static accesor
+(Equation)custom;
@end

//Step 2 Implementation
@implementation Ease (NameYourCategory)
//Instance custom equation as static var
static Equation custom = ^(double t, double b, double c, double d){
    //Set custom equation here.
    return c * t / d + b;
};
//Add static accessor to static var
+(Equation)custom{return custom;};
@end

@implementation CustomEase

-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    
    if (self)
    {
        //Step 3 Use it
//        Tween* tween = [[Tween alloc] init:self
//                                  duration:1.0f
//                                      ease:Ease.custom
//                                      keys:@{@"alpha" : @1.0f,
//                                             @"frame" : [NSValue valueWithCGRect:CGRectMake(20.0f, 20.0f, 280.0f, 280.0f)],
//                                             @"backgroundColor" : [UIColor blueColor]
//                                             }];
    }
    return self;
}


@end
