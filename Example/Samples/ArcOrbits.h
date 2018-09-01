//
//  ArcOrbits.h
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/22/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CocoaTweener/CocoaTweener.h>

@interface ArcOrbits : UIView

@property (strong) PDFImageView* background;
@property (strong) PDFImageView* sunFire;
@property (strong) RotationAim* fireAim;

@property (strong) PDFImageView* sun;

@property (strong) PDFImageView* earth;
@property (strong) ArcAim* earthAim;

@property (strong) UIView* moon;
@property (strong) ArcAim* moonAim;

@property (strong) UIView* mars;
@property (strong) ArcAim* marsAim;

@property (strong) PDFImageView* jupyter;
@property (strong) ArcAim* jupyterAim;

@property (strong) PDFImageView* saturn;
@property (strong) ArcAim* saturnAim;


@end
