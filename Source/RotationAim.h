//
//  RotationAim.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 8/14/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^AimRotationHandler)(CGFloat rotation);

@interface RotationAim : NSObject

@property (strong) AimRotationHandler onUpdateRotation;
@property (strong) UIView* target;//Optional
@property (nonatomic) CGFloat angle;//in degrees
@property (nonatomic) CGFloat angleOffset;//in degrees//getter =getAngleOffset
@property (nonatomic) CGFloat rotation;//in radians
@property (nonatomic) CGFloat rotationOffset;
@property (nonatomic) CGFloat distance;
@property (nonatomic) CGPoint point;//TODO: rename to "orientationPoint"

@end
