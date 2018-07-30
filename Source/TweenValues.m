//
//  TweenValues.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/28/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "TweenValues.h"

@implementation TweenValues

-(id)initWithStartValue:(float*)valuestart valueComplete:(float*)valuecomplete originalValueComplete:(float*)originalvaluecomplete floatSize:(int)floatSize
{
    if ([super init])
    {
        if (self)
        {
            _size = floatSize;
            self.valueStart            =    valuestart;
            self.valueComplete        =    valuecomplete;
            self.originalValueComplete    =    originalvaluecomplete;
        }
        
        return self;
    }
    return nil;
}

-(BOOL)completed
{
    BOOL isEqual = YES;
    
    for (int indexFloat = 0; indexFloat < self.size; indexFloat++)
    {
        if (self.valueStart[indexFloat] != self.valueComplete[indexFloat]){isEqual = NO; break;}
    }
    
    return isEqual;
}

-(void)setValueStart:(float *)valueStart
{
    if (_valueStart != NULL)
    {
        free(_valueStart);
    }
    _valueStart = valueStart;
}

-(void)setValueComplete:(float *)valueComplete
{
    if (_valueComplete != NULL)
    {
        free(_valueComplete);
    }
    _valueComplete = valueComplete;
}

-(void)dealloc
{
    //TODO: safe free ?
    if (_valueStart != NULL)
    {
        free(_valueStart);
    }
    if (_valueComplete != NULL)
    {
        free(_valueComplete);
    }
    //self.valueComplete;
    //self.originalValueComplete;
}

@end
