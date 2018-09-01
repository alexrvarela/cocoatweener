//
//  ArcAim.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 8/14/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "ArcAim.h"
#import "BasicMath.h"

@implementation ArcAim

-(void)setArcAngleOffset:(float)value
{
    _arcAngleOffset = [BasicMath toRadians:value];
    [self update];
}

-(void)setArcAngle:(float)value
{
    _arcAngle = [BasicMath toRadians:value];
    [self update];
}

-(void)setRadius:(float)radius
{
    _radius = radius;
    [self update];
}

-(void)setCenter:(CGPoint)center
{
    _center = center;
    [self update];
}

-(void)setArcPoint:(CGPoint)point
{
    _arcPoint = point;
    //TODO:add arcAngleOffset?
    _arcAngle = [BasicMath angle:_center end:_arcPoint];
    [self update];
}

//TODO GETTER, CONVERT TO ANGLE from radians

-(void)update
{
    //super update?
    CGPoint rotation = [BasicMath arcRotationPoint:self.arcAngle + self.arcAngleOffset radius:self.radius];
    
    self.target.center = CGPointMake(self.center.x + rotation.x, self.center.y + rotation.y);
    
    if (self.orientToArc)
    {
        self.point = self.center;
    }
}


@end
