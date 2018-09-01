//
//  StringAim.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 8/14/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "StringAim.h"

@implementation StringAim

+(NSString*)linear:(float)interpolation from:(NSString*)from to:(NSString*)to
{
    //swap char per char
    //remove exceded chars
    return @"";
}

+(NSString*)length:(float)value from:(NSString*)from to:(NSString*)to
{
//    printf("interpolation : %f\n", value);
    float totalLength = from.length + to.length;
    float ratio = from.length / totalLength;
    
    NSString* string = @"";
    
    if (value < ratio)
    {
        float transformValue = 1.0 - (value / ratio);
        
        if(from != nil && from.length > 0)
        {
            int end = transformValue * from.length;
            if (end > 0)string = [from substringWithRange:NSMakeRange(0, end)];
        }
    }
    else
    {
        float transformValue = 1.0 - ((1.0 - value) / (1.0 - ratio));
        
        if(to != nil && to.length > 0)
        {
            int end = transformValue * to.length;
            if (end > 0)string = [to substringWithRange:NSMakeRange(0, end)];
        }
    }
    
    return string;
}

+(NSString*)random:(float)interpolation from:(NSString*)from to:(NSString*)to
{
    //fill with random characters
    return @"";
}

-(void)setInterpolation:(float)value
{
    if (self.from == nil || self.to == nil)return;
    
    _interpolation = value;
    
    //swith case
    
    //on update handler?
    
    if (self.target == nil)return;
    
    //set target
    self.target.text = [StringAim length:value from:self.from to:self.to];
}

@end
