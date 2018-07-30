//
//  AnimateText.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/13/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CocoaTweener/CocoaTweener.h>

@interface AnimateText : UIView

@property (strong) UILabel* label;
@property (strong) NSArray<NSString*>* words;
@property (strong) NSString* currentString;
@property (nonatomic) float interpolation;
@property (strong) Tween* hideText;
@property (strong) Tween* showText;

@end
