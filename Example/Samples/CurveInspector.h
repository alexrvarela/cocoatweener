//
//  CurveInspector.h
//  Examples
//
//  Created by Alejandro Ramirez Varela on 2/24/19.
//  Copyright © 2019 Alejandro Ramirez Varela. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CocoaTweener/CocoaTweener.h>

@interface CurveInspector : UIControl

@property (nonatomic, assign) Equation ease;
@property (strong) UILabel* label;
@property (strong) UIView* border;
@property (strong) UIView* curve;
@property (strong) UIView* asset;
@property (strong) UIView* linex;
@property (strong) UIView* liney;
@property (strong) PDFImageView* playIcon;

@end
