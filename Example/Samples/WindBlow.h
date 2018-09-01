//
//  WindBlow.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/13/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CocoaTweener/CocoaTweener.h>

@interface WindBlow : UIView

@property (strong) PDFImageView* dart1;
@property (strong) PDFImageView* dart2;
@property (strong) PDFImageView* dart3;
@property (nonatomic) float blow;
@property (nonatomic) RotationAim* rotation;

@end
