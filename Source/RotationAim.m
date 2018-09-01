//
//  RotationAim.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 8/14/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "RotationAim.h"
#import "BasicMath.h"

@implementation RotationAim

//Set Rotation in degrees
-(void)setAngle:(CGFloat)value
{
    _angle = value;
    //convert to radians
    self.rotation = [BasicMath toRadians:value];
}
//TODO: getter

-(void)setAngleOffset:(CGFloat)value
{
    _angleOffset = value;
    self.rotationOffset = [BasicMath toRadians:value];
}

//Set Rotation in radians
-(void)setRotationOffset:(CGFloat)value
{
    _rotationOffset = value;
    self.rotation = _rotation;//refresh!
}

-(void)setRotation:(CGFloat)value
{
    _rotation = value;
    
    if (self.onUpdateRotation != nil)
    {
        self.onUpdateRotation(_rotation + _rotationOffset);
    }
    
    if (self.target != nil)
    {
        self.target.transform = CGAffineTransformMakeRotation(_rotation + _rotationOffset);
    }
}

//Convert distance to specific angle
-(void)setDistance:(CGFloat)value
{
    _distance = value;
    self.angle = (value - floor(value)) * 360.0f;
}

//orient target to specific point
-(void)setPoint:(CGPoint)point
{
    _point = point;
    //TODO:add offset?
    self.rotation = [BasicMath angle:self.target.center end:point];
}


@end
