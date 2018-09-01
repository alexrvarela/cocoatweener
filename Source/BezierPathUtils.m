//
//  BezierPathUtils.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 5/4/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

//https://en.wikipedia.org/wiki/Bezier_curve

//Credits:
//https://gist.github.com/pbeshai/72c446033a98f99ce1e1371c6eee9644

#import "BasicMath.h"
#import "BezierPathUtils.h"

@implementation BezierPathUtils

//Linear interpolation between 2 points
+ (CGPoint)linearInterpolation:(CGFloat)time
                         start:(CGPoint)start
                         end:(CGPoint)end
{
    return CGPointMake([BasicMath linear:time a:start.x b:end.x],
                       [BasicMath linear:time a:start.y b:end.y]);
}

//Quadratic interpolation between 3 points
+ (CGPoint)quadInterpolation:(CGFloat)time
                  startPoint:(CGPoint)start
                controlPoint:(CGPoint)control
                    endPoint:(CGPoint)end
{
    
    CGFloat x = [BasicMath quad:time a:start.x b:control.x c:end.x];
    CGFloat y = [BasicMath quad:time a:start.y b:control.y c:end.y];
    return CGPointMake(x, y);
}

//Bezier Cubic interpolation between 4 points
+ (CGPoint)bezierCubicInterpolation:(CGFloat)time
                         startPoint:(CGPoint)start
                  controlStartPoint:(CGPoint)controlStart
                    controlEndPoint:(CGPoint)controlEnd
                         toEndPoint:(CGPoint)end
{
    return CGPointMake([BasicMath cubic:time a:start.x b:controlStart.x c:controlEnd.x d:end.x],
                       [BasicMath cubic:time a:start.y b:controlStart.y c:controlEnd.y d:end.y]);
    
}

//Quadratic angle
+ (CGFloat)quadAngle:(CGFloat)time
          startPoint:(CGPoint)start
        controlPoint:(CGPoint)control
            endPoint:(CGPoint)end
{
    CGFloat x = [BasicMath quadTangent:time a:start.x b:control.x c:end.x];
    CGFloat y = [BasicMath quadTangent:time a:start.y b:control.y c:end.y];
    return atan2(y, x);
}

//Bezier cubic angle
+ (CGFloat)bezierCubicAngle:(CGFloat)time
          startPoint:(CGPoint)start
   controlStartPoint:(CGPoint)controlStart
     controlEndPoint:(CGPoint)controlEnd
          toEndPoint:(CGPoint)end
{
    CGFloat x = [BasicMath cubicTangent:time a:start.x b:controlStart.x c:controlEnd.x d:end.x];
    CGFloat y = [BasicMath cubicTangent:time a:start.y b:controlStart.y c:controlEnd.y d:end.y];
    return atan2(y, x);
}

//Quad lenght
+ (CGFloat)quadLength:(CGPoint)start
         controlPoint:(CGPoint)control
             endPoint:(CGPoint)end
{
    //TODO:Pass array pointer to collect points
    int divisions = 50;
    float step = 1.0f / (float)divisions;

    //Optimize number of divisions
    CGPoint testPoint =  [self quadInterpolation:step
                                                 startPoint:start
                                               controlPoint:control
                                                   endPoint:end];
    
    float testLength = [BasicMath length:start end:testPoint];
    //fit divisions
    divisions = ((float)divisions) * (testLength / 5.0f);
    step = 1.0f / (float)divisions;
    
    float length = 0.0f;
    CGPoint prevPoint = start;
    
    for (int i = 1; i < divisions; i++)
    {
        CGPoint point =  [self quadInterpolation:i * step
                                      startPoint:start
                                    controlPoint:control
                                        endPoint:end];
        
        length += [BasicMath length:prevPoint end:point];
        prevPoint = point;
    }
    
    return length;
}


//Bezier cubic lenght
+ (CGFloat)bezierCubicLength:(CGPoint)start
           controlStartPoint:(CGPoint)controlStart
             controlEndPoint:(CGPoint)controlEnd
                  toEndPoint:(CGPoint)end
{
    //TODO:Pass array pointer to collect points
    
    int divisions = 50;
    float step = 1.0f / (float)divisions;
    
    //TODO:optimize number of divisions
    CGPoint testPoint = [self bezierCubicInterpolation:step
                                             startPoint:start
                                      controlStartPoint:controlStart
                                        controlEndPoint:controlEnd
                                             toEndPoint:end];
    
    float testLength = [BasicMath length:start end:testPoint];
    //fit divisions
    divisions = ((float)divisions) * (testLength / 5.0f);
    step = 1.0f / (float)divisions;

    float length = 0.0f;
    CGPoint prevPoint = start;
    
    for (int i = 1; i < divisions; i++)
    {
        CGPoint point =  [self bezierCubicInterpolation:i * step
                                             startPoint:start
                                      controlStartPoint:controlStart
                                        controlEndPoint:controlEnd
                                             toEndPoint:end];
        
        length += [BasicMath length:prevPoint end:point];
        prevPoint = point;
    }
    
    return length;
}

//Calculate entire path lenght
+ (CGFloat)bezierPathLength:(CGPathRef)path
{
    //TODO: pass array to collect separate lenghts
    return  0.0f;
}

//Cubic lenght calculation (4 points)

//Quad lenght to calculation

//Cubic lenght calculation


@end
