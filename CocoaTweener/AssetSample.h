//
//  Asset.h
//  Animation
//
//  Created by Alejandro R. Varela on 04/05/11.
//  Copyright 2011 __MyCompanyName__ All rights reserved.
//

#import <UIKit/UIKit.h>

//Custom UIView
@interface AssetSample : UIView

//special properties
@property (nonatomic) float specialProperty;
@property (nonatomic) float rotationAngle;
@property float f;
@property (strong) UIColor* color;

-(void)onStartExample;
-(void)onUpdateExample;
-(void)onCompleteExample;

@end
