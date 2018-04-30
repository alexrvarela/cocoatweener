//
//  AnimateText.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/13/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "AnimateText.h"
#import "CocoaTweener.h"

@implementation AnimateText

-(id)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:66.0f/255.0f green:0.0f blue:162.0f/255 alpha:1.0f];
        
        srandom((int)time(NULL));//seed arc4random first
        
        self.words = @[@"Hello", @"Hola", @"Bonjour", @"Ciao", @"Olá", @"Hallo", @"こんにちは", @"你好", @"Hej"];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,
                                                               self.center.y - 60.0f,
                                                               self.frame.size.width - 40.0f,
                                                               60.0f)];
        
        self.label.font = [UIFont systemFontOfSize:52.0f weight:UIFontWeightLight];
        self.label.textColor = [UIColor whiteColor];
        self.label.text = [self randomText];
        self.currentString = self.label.text;
        [self addSubview:self.label];
        
        self.interpolation = 1.0f;//start
        self.hideText = [[Tween alloc] init:self
                          duration:0.25f
                              ease:kEaseNone
                              keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithFloat:0.0f], @"interpolation",
                                    nil]
                                      delay:0.0f
                                 completion:^{
                                     printf("\nhide complete\n");
                                     //change text
                                     self.currentString = [self randomText];
                                     //show text
                                     self.showText.duration =  0.035f * (float)self.currentString.length;
                                     [CocoaTweener addTween:self.showText];
                                 }
                         ];
        
        self.showText = [[Tween alloc] init:self
                               duration:0.25f
                                   ease:kEaseNone
                                   keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [NSNumber numberWithFloat:1.0f], @"interpolation",
                                         nil]
                                  delay:0.0f
                                 completion:^{
                                     printf("\nshow complete\n");
                                     [self performSelector:@selector(swapText) withObject:nil afterDelay:1.0f];
                                 }
                     ];
        /*
        UIButton* swapButton = [[UIButton alloc] initWithFrame:CGRectMake(20.0f,
                                                                          self.frame.size.height -  70.0f,
                                                                          self.frame.size.width - 40.0f,
                                                                          50.0f)];
        [swapButton setTitle:@"SWAP TEXT" forState:UIControlStateNormal];
        [swapButton addTarget:self action:@selector(swapText) forControlEvents:UIControlEventTouchUpInside];
        [swapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        swapButton.layer.cornerRadius = 7.0f;
        swapButton.layer.borderColor = [UIColor whiteColor].CGColor;
        swapButton.layer.borderWidth = 2.0f;
        [self addSubview:swapButton];
        //*/
        
        [self swapText];
    }
    
    return self;
}


-(void)swapText
{
    [CocoaTweener removeTweens:self];
    [CocoaTweener addTween:self.hideText];
}

-(void)setInterpolation:(float)value
{
    _interpolation = value;
    
    NSString* s = @"";
    
    if(self.currentString != nil && self.currentString.length > 0)
    {
        int end = value * self.currentString.length;
        
        if (end > 0)
            s = [self.currentString substringWithRange:NSMakeRange(0, end)];
    }
    
    self.label.text = s;
}

-(NSString*)randomText
{
    int rand = (int) arc4random() % (self.words.count - 1);
    return [self.words objectAtIndex:rand];
}

@end
