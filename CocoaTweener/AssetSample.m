//
//  Asset.m
//  Animation
//
//  Created by Alejandro R. Varela on 04/05/11.
//  Copyright 2011 __MyCompanyName__ All rights reserved.
//

#import "AssetSample.h"

@implementation AssetSample

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code.
        self.color = [UIColor colorWithRed:0.0f green:1.0f blue:0.5f alpha:1.0f];
    }
    return self;
}

//---- Use this method for special properties ----
-(void)setSpecialProperty:(float)interpolationValue
{
    _specialProperty = interpolationValue;
}

//-(float)getSpecialProperty{return specialProperty;}

-(void)onStartExample
{
    //onStart
    printf("ons start\n");
}

-(void)onUpdateExample
{
    //onUpdate
    //printf("call update inside target : %f\n", self.specialProperty);
    

}

-(void)setRotationAngle:(float)rotationAngle
{
    _rotationAngle = rotationAngle;
    
    /*
     self.layer.transform = CATransform3DMakeRotation ((self.specialProperty * 360.0f) * M_PI / 180.0,
     0.0f,
     0.0f,
     1.0f);
     //*/
    
    self.transform = CGAffineTransformMakeRotation((_rotationAngle * 360.0f) * M_PI / 180.0);
    
    printf("interpolation : %f\n", self.rotationAngle);
    printf("transform m : %s\n", NSStringFromCGAffineTransform(self.transform).UTF8String);
}

-(void)onCompleteExample
{
    //onComplete
    printf("ons complete\n");
    self.backgroundColor = [UIColor greenColor];
}

@end
