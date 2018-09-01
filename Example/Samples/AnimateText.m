//
//  AnimateText.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/13/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "AnimateText.h"

@implementation AnimateText

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:65.0f/255.0f green:50.0f/255.0f blue:160.0f/255 alpha:1.0f];
        
        //TODO:move to BasicMath.h
        srandom((int)time(NULL));//seed arc4random first
        
        self.words = @[@"Hello", @"Hola", @"Bonjour", @"Ciao", @"Olá", @"Hallo", @"Ohayo", @"Konnichiwa", @"Ni hau", @"Hej", @"Guten tag", @"Namaste", @"Salaam", @"Merhaba", @"Szia"];
        NSString* randomText = [self randomText];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                               self.center.y - 60.0f,
                                                               self.frame.size.width - 40.0f,
                                                               60.0f)];
        
        self.label.font = [UIFont systemFontOfSize:58.0f weight:UIFontWeightLight];
        self.label.textColor = [UIColor whiteColor];
        self.label.text = randomText;
        [self addSubview:self.label];

        self.aim = [[StringAim alloc] init];
        self.aim.from = randomText;
        self.aim.to = [self changeText:randomText];
        self.aim.target = self.label;
        
        //TODO: fix bug, make tweens reusable.
//        //Instance show text tween
//        self.showText = [[Tween alloc] init:self
//                                   duration:0.15f
//                                       ease:kEaseNone
//                                       keys:[NSDictionary dictionaryWithObjectsAndKeys:
//                                             [NSNumber numberWithFloat:1.0f], @"interpolation",
//                                             nil]
//                                      delay:0.0f
//                                 completion:^{
//                                     printf("show complete\n");
//                                     [self performSelector:@selector(swapText) withObject:nil afterDelay:0.5f];
//                                 }
//                         ];
//
//        //Instance hide text tween
//        self.hideText = [[Tween alloc] init:self
//                          duration:0.25f
//                              ease:kEaseNone
//                              keys:[NSDictionary dictionaryWithObjectsAndKeys:
//                                    [NSNumber numberWithFloat:0.0f], @"interpolation",
//                                    nil]
//                                      delay:0.0f
//                                 completion:^{
//                                     printf("hide complete\n");
//                                     //change text
//                                     NSString* lastString = self.currentString;
//
//                                     printf("update string\n");
//                                     while ([self.currentString isEqualToString:lastString])
//                                     {
//                                         self.currentString = [self randomText];
//                                     }
//
//                                     //show text
//                                     //update duration
//                                     self.showText.duration =  0.025f * (float)self.currentString.length;
//                                     printf("set new duration %f\n", self.showText.duration);
//                                     printf("add show text tween\n");
//                                     [CocoaTweener addTween:self.showText];
//                                 }
//                         ];
        //[self swapText];
    [self swapText];
    }
    
    return self;
}

-(NSString*)changeText:(NSString*)oldText
{
    
    NSString* newString = oldText;
    
    while ([newString isEqualToString:oldText])
    {
        newString = [self randomText];
    }
    
    return newString;
}

-(void)swapText
{
    self.aim.from = self.aim.to;
    self.aim.to = [self changeText:self.aim.to];
    self.aim.interpolation = 0.0f;
    
    [CocoaTweener removeTweens:self.aim];//remove
    [CocoaTweener addTween:[[Tween alloc] init:self.aim
                                      duration:0.5f
                                          ease:kEaseNone
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:1.0f], @"interpolation",
                                                nil]
                                         delay:0.0f
                                    completion:^{
                                        [self performSelector:@selector(swapText) withObject:nil afterDelay:0.5f];
                                    }
                            ]
     ];
}

-(NSString*)randomText
{
    int rand = (int) arc4random() % (self.words.count - 1);
    return [self.words objectAtIndex:rand];
}


//deprecate
//-(void)setInterpolation:(float)value
//{
//    printf("interpolation : %f\n", value);
//    _interpolation = value;
//
//    NSString* s = @"";
//
//    if(self.currentString != nil && self.currentString.length > 0)
//    {
//        int end = value * self.currentString.length;
//
//        if (end > 0)
//            s = [self.currentString substringWithRange:NSMakeRange(0, end)];
//    }
//
//    self.label.text = s;
//}


@end
