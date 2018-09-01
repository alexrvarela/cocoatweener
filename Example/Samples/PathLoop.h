//
//  PathLoop.h
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/17/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CocoaTweener/CocoaTweener.h>

@interface PathLoop : UIView

@property (strong) PathAim* tweenPath;
@property (strong) UIView* pathView;
@property (strong) PDFImageView* bee;
@property (strong) PDFImageView* flower;
@property (strong) UILabel* label;
@end
