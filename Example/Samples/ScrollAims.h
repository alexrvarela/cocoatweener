//
//  ScrollAims.h
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/22/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CocoaTweener/CocoaTweener.h>

@interface ScrollAims : UIView <UIScrollViewDelegate>

@property (strong) UIScrollView* scrollview;
@property (strong) UIView* sand;
@property (strong) PDFImageView* body;
@property (strong) PDFImageView* head;
@property (strong) RotationAim* rotationAim;
@property (strong) ArcAim* arcAim;
@property float lastOffset;

@end
