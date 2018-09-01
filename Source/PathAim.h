//
//  PathAim.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 8/9/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaTweener/CocoaTweener.h>
#import "RotationAim.h"
@interface PathAim : RotationAim

//@property (strong) UIView* target;
@property (nonatomic) CGPathRef CGPath;
@property (strong, nonatomic, getter=getPath) UIBezierPath* path;

//private
@property (strong) NSMutableArray<NSNumber*>* lenghts;
@property (strong) NSMutableArray<NSNumber*>* ratios;
@property (strong) NSMutableArray<NSArray<NSValue*>*>* points;

//TODO:use origin or center?
@property (nonatomic, readonly) float lenght;
@property (nonatomic) float interpolation;
@property BOOL orientToPath;

//TODO:onUpdate handler

@end
