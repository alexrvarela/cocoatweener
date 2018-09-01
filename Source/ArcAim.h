//
//  ArcAim.h
//  CarthageTests
//
//  Created by Alejandro Ramirez Varela on 8/14/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RotationAim.h"

@interface ArcAim : RotationAim

//target
@property BOOL orientToArc;
@property (nonatomic) CGPoint center;
@property (nonatomic) float radius;
@property (nonatomic) float arcAngle;
@property (nonatomic) float arcAngleOffset;
@property (nonatomic) CGPoint arcPoint;

@end
