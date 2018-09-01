//
//  PathAim.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 8/9/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "BezierPathUtils.h"
#import "BasicMath.h"
#import "PathAim.h"

static void getPathPointsApplier(void* info, const CGPathElement* element)
{
    NSMutableArray<NSArray<NSValue*>*>* points = (__bridge NSMutableArray*) info;
    
    if (points.count == 0 && element->type != kCGPathElementMoveToPoint)
    {
        //append point zero
        [points addObject:@[[NSValue valueWithCGPoint:CGPointZero]]];
    }
    
    switch (element->type)
    {
        case kCGPathElementMoveToPoint:
        {
//            printf("move to\n");
            [points addObject:@[[NSValue valueWithCGPoint:element->points[0]]]];
        }
            break;
        case kCGPathElementAddLineToPoint:
        {
//            printf("line to\n");
            [points addObject:@[[NSValue valueWithCGPoint:element->points[0]]]];
        }
            break;
        case kCGPathElementAddQuadCurveToPoint:
        {
//            printf("quad curve to\n");
            [points addObject:@[
                                [NSValue valueWithCGPoint:element->points[0]],
                                [NSValue valueWithCGPoint:element->points[1]]
                                ]];
        }
            break;
        case kCGPathElementAddCurveToPoint:
        {
//            printf("curve to\n");
            [points addObject:@[
                                [NSValue valueWithCGPoint:element->points[0]],
                                [NSValue valueWithCGPoint:element->points[1]],
                                [NSValue valueWithCGPoint:element->points[2]]
                                ]];
        }
            break;
        case kCGPathElementCloseSubpath:
//            printf("close sub path\n");
            break;
    }
}

@implementation PathAim

-(id)init
{
    self = [super init];
    if (self)
    {
        self.orientToPath = false;
        self.interpolation = 0.0;
    }
    return self;
}

-(void)append:(NSArray<NSValue*>*)points
{
    //recalculate
    [self update];
}

-(void)setCGPath:(CGPathRef)CGPath
{
    _CGPath = CGPath;
    self.points = [[NSMutableArray alloc] init];//empty
    CGPathApply(CGPath, (__bridge void*)self.points, &getPathPointsApplier);
    [self update];
}

-(void)update
{
    if (self.points == nil || self.points.count == 0)return;
    self.ratios = [[NSMutableArray alloc] init];
    self.lenghts = [[NSMutableArray alloc] init];
    
    _lenght = 0.0;
    
    //get first point
    CGPoint originPoint = [[self.points objectAtIndex:0] objectAtIndex:0].CGPointValue;
    NSUInteger index = 0;
    
    for (NSArray<NSValue*>* pathPoints in self.points)
    {
//        NSUInteger index = [self.points indexOfObject:pathPoints];
        printf("index : %i\n", (int)index);
        if ( index > 0 )//igonre first element
        {
            float l = 0.0f;
            CGPoint endPoint = [pathPoints lastObject].CGPointValue;
            //Move to //Line to
            if (pathPoints.count == 1)//Linear
            {
                printf("linear\n");
                l = [BasicMath length:originPoint
                                       end:endPoint];
                printf("lenght : %f\n", l);
            }
            if (pathPoints.count == 2)//Quad
            {
                printf("quad\n");
                l = [BezierPathUtils quadLength:originPoint
                                   controlPoint:[pathPoints objectAtIndex:0].CGPointValue
                                       endPoint:endPoint];
                printf("lenght : %f\n", l);
            }
            if (pathPoints.count == 3)//Bezier
            {
                printf("bezier\n");
                l = [BezierPathUtils bezierCubicLength:originPoint
                                     controlStartPoint:[pathPoints objectAtIndex:0].CGPointValue
                                       controlEndPoint:[pathPoints objectAtIndex:1].CGPointValue
                                            toEndPoint:endPoint];
                printf("lenght : %f\n", l);
            }
            
            originPoint = endPoint;
            [self.ratios addObject:[NSNumber numberWithFloat:_lenght + l]];//prevent first element
            [self.lenghts addObject:[NSNumber numberWithFloat:l]];//prevent first element
            _lenght += l;
        }
        
        index++;
    }
    
    printf("total lenght : %f\n", _lenght);
    printf("ratios : %s\n", [NSString stringWithFormat:@"%@", self.ratios].UTF8String);
    printf("points : %s\n", [NSString stringWithFormat:@"%@", self.points].UTF8String);
    //calculate ratios
}

//TODO: make points editable and generate CGPath
//-(CGPathRef)getCGPath
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    //build path
//    return path;
//}

-(void)setPath:(UIBezierPath *)path
{
    [self setCGPath:path.CGPath];
}

//to BezierPath
-(UIBezierPath*)getPath
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    path.CGPath = self.CGPath;
    return path;
}

-(void)setInterpolation:(float)value
{
    if (self.points == nil || self.points.count == 0)return;
    
    _interpolation = value;
    
    //TODO:verify handler:
    
    //TODO:verify target
//    if(self.target != nil){}
    
    //get index
    int pathIndex = 0;
//    float pathInterpolation = 0.0f;
    
    for (int indexRatio = 0; indexRatio < self.ratios.count; indexRatio++)
    {
        float location =  [self.ratios objectAtIndex:indexRatio].floatValue / self.lenght;
        pathIndex = indexRatio;
        if (value < location){break;}
    }
    
    float difference = (pathIndex > 0) ? self.ratios[pathIndex - 1].floatValue / _lenght : 0.0f;
    float pathInterpolation = (value - difference)  / (self.lenghts[pathIndex].floatValue / _lenght);

    //get real interpolation
    NSArray<NSValue*>* pathPoints = [self.points objectAtIndex:pathIndex + 1];
    CGPoint originPoint = [[self.points objectAtIndex:pathIndex] lastObject].CGPointValue;
    CGPoint endPoint = [pathPoints lastObject].CGPointValue;
    
    if (pathPoints.count == 1)//Linear
    {
        self.target.center = [BezierPathUtils linearInterpolation:pathInterpolation
                                                            start:originPoint
                                                              end:endPoint];
        if(self.orientToPath)
        {
            self.rotation =  [BasicMath angle:originPoint
                                                end:endPoint];
        }
    }
    if (pathPoints.count == 2)//Quad
    {
        self.target.center = [BezierPathUtils quadInterpolation:pathInterpolation
                                                     startPoint:originPoint
                                                   controlPoint:[pathPoints objectAtIndex:0].CGPointValue
                                                       endPoint:endPoint];
        
        if(self.orientToPath)
        {
            self.rotation = [BezierPathUtils quadAngle:pathInterpolation
                                            startPoint:originPoint
                                          controlPoint:[pathPoints objectAtIndex:0].CGPointValue
                                              endPoint:endPoint];
        }
    }
    if (pathPoints.count == 3)//Bezier
    {
        //trasnlate
        self.target.center = [BezierPathUtils bezierCubicInterpolation:pathInterpolation
                                                            startPoint:originPoint
                                                     controlStartPoint:[pathPoints objectAtIndex:0].CGPointValue
                                                       controlEndPoint:[pathPoints objectAtIndex:1].CGPointValue
                                                            toEndPoint:endPoint];
        //rotate
        if(self.orientToPath)
        {
            self.rotation = [BezierPathUtils bezierCubicAngle:pathInterpolation
                                                   startPoint:originPoint
                                            controlStartPoint:[pathPoints objectAtIndex:0].CGPointValue
                                              controlEndPoint:[pathPoints objectAtIndex:1].CGPointValue
                                                   toEndPoint:endPoint];
        }
    }
}

@end
