//
//  ScrollTimeline.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 4/5/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CocoaTweener/CocoaTweener.h>

@interface ScrollTimeline : UIView <UIScrollViewDelegate>

@property (strong) UIScrollView* scrollview;
@property (strong) UIView* container;

@property (strong) Timeline* timeline;

@property (strong) PDFImageView* stars;
@property (strong) PDFImageView* comet;
@property (strong) PDFImageView* rocket;
@property (strong) PDFImageView* fire;
@property (strong) PDFImageView* sun;
@property (strong) PDFImageView* earth;
@property (strong) PDFImageView* mars;
@property (strong) PDFImageView* jupyter;
@property (strong) PDFImageView* saturn;
@property (strong) PDFImageView* ufo;
@property (strong) PDFImageView* moon;
@property (strong) PDFImageView* spaceman;

-(void)freeze;

@end
