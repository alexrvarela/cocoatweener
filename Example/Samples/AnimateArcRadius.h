//
//  AnimateArcRadius.h
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/22/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CocoaTweener/CocoaTweener.h>

@interface AnimateArcRadius : UIView

@property (strong) UIView* eyeBall;
@property (strong) UIView* eyeLipTop;
@property (strong) UIView* eyeLipBottom;
@property (strong) PDFImageView* eyePupil;
@property (strong) ArcAim* aim;

@property bool isClosed;
@property CGRect opennedTop;
@property CGRect opennedBottom;
@property CGRect closedTop;
@property CGRect closedBottom;

@end
