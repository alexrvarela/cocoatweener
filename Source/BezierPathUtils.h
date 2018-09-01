//
//  BezierPathUtils.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 5/4/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BezierPathUtils : NSObject

//Linear interpolation between 2 points
+ (CGPoint)linearInterpolation:(CGFloat)time
                         start:(CGPoint)start
                           end:(CGPoint)end;

//Quadratic interpolation between 3 points
+ (CGPoint)quadInterpolation:(CGFloat)time
                  startPoint:(CGPoint)start
                controlPoint:(CGPoint)control
                    endPoint:(CGPoint)end;

//Cubic interpolation between 4 points
+ (CGPoint)bezierCubicInterpolation:(CGFloat)time
                         startPoint:(CGPoint)start
                  controlStartPoint:(CGPoint)controlStart
                    controlEndPoint:(CGPoint)controlEnd
                         toEndPoint:(CGPoint)end;

//Quadratic angle
+ (CGFloat)quadAngle:(CGFloat)time
          startPoint:(CGPoint)start
        controlPoint:(CGPoint)control
            endPoint:(CGPoint)end;

//Bezier cubic angle
+ (CGFloat)bezierCubicAngle:(CGFloat)time
                 startPoint:(CGPoint)start
          controlStartPoint:(CGPoint)controlStart
            controlEndPoint:(CGPoint)controlEnd
                 toEndPoint:(CGPoint)end;

//Quad lenght
+ (CGFloat)quadLength:(CGPoint)start
         controlPoint:(CGPoint)control
             endPoint:(CGPoint)end;

//Bezier cubic lenght
+ (CGFloat)bezierCubicLength:(CGPoint)start
           controlStartPoint:(CGPoint)controlStart
             controlEndPoint:(CGPoint)controlEnd
                  toEndPoint:(CGPoint)end;

@end
