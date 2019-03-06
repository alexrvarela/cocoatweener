//
//  EaseCurves.h
//  Examples
//
//  Created by Alejandro Ramirez Varela on 2/24/19.
//  Copyright © 2019 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurveInspector.h"

@interface EaseCurves : UIView

@property (strong) UIScrollView* scrollview;
@property (strong) UIScrollView* easeSelector;
@property (strong) UIView* selectorContainer;
@property (strong) UIButton* selectorButton;
@property (strong) NSArray* easeList;
@property (strong) NSMutableArray<UIButton*>* buttons;
@property (strong) NSMutableArray<CurveInspector*>* inspectors;

@end
