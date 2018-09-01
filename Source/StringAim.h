//
//  StringAim.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 8/14/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    kStringTransitionLinear,
    kStringTransitionRandom,
    kStringTransitionLenght
    //kStringTransitionAlphabet,
}kStringTransition;

@interface StringAim : NSObject

//TODO:Support for:  UILabel, UITextField, UITextView, UIButton
@property (strong) UILabel* target;//Optional
@property (nonatomic) NSString* from;
@property (nonatomic) NSString* to;
@property (nonatomic) float interpolation;
@property (nonatomic) kStringTransition transition;

@end
