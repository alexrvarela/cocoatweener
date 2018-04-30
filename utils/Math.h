//
//  Math.h
//  Aletz
//
//  Created by Alejandro varela on 05/05/11.
//  Copyright 2011 GT systems All rights reserved.
//

/*
#define M_E         2.71828182845904523536028747135266250   // e
#define M_LOG2E     1.44269504088896340735992468100189214   // log 2e
#define M_LOG10E    0.434294481903251827651128918916605082  // log 10e
#define M_LN2       0.693147180559945309417232121458176568  // log e2
#define M_LN10      2.30258509299404568401799145468436421   // log e10
#define M_PI        3.14159265358979323846264338327950288   // pi
#define M_PI_2      1.57079632679489661923132169163975144   // pi/2
#define M_PI_4      0.785398163397448309615660845819875721  // pi/4
#define M_1_PI      0.318309886183790671537767526745028724  // 1/pi
#define M_2_PI      0.636619772367581343075535053490057448  // 2/pi
#define M_2_SQRTPI  1.12837916709551257389615890312154517   // 2/sqrt(pi)
#define M_SQRT2     1.41421356237309504880168872420969808   // sqrt(2)
#define M_SQRT1_2   0.707106781186547524400844362104849039  // 1/sqrt(2)

#define	MAXFLOAT	((float)3.40282346638528860e+38)
//*/

#define DEGREES_TO_RADIANS(__DEGREE__) ((__DEGREE__) * M_PI / 180.0)
#define RADIANS_TO_DEGREES(__RADIAN__) ((__RADIAN__) * 180 / M_PI)
#define ARC4RANDOM_MAX      0x100000000

@class Math;

static inline float CalculateDistance(CGPoint P1, CGPoint P2)
{
	float a = P1.x - P2.x;
	float b = P1.y - P2.y;
    
    return sqrt(a * a + b * b);
}

static inline float CalculateAngle(CGPoint P1, CGPoint P2)
{
	return atan2(P1.y - P2.y, P1.x - P2.x);
}

static inline CGPoint CalculateRotation(float angle, float radius)
{
	float x = cos(angle) * radius;
	float y = sin(angle) * radius;
	
	return CGPointMake(x, y);
}

static inline CGPoint CalculateEllipseRotation(float angle, float  xradius, float yradius)
{
	float x = cos(angle) * xradius;
	float y = sin(angle) * yradius;
	
	return CGPointMake(x, y);
}

static inline CGPoint CGPointAdd(CGPoint p1, float addition)
{
    CGPoint sum = { p1.x + addition, p1.y + addition };
    return sum;
}

static inline CGPoint CGPointAddPoint(CGPoint p1, CGPoint p2)
{
    CGPoint sum = { p1.x + p2.x, p1.y + p2.y };
    return sum;
}

static inline CGPoint CGPointSubtract(CGPoint p1, float subtraction)
{
    CGPoint sum = { p1.x - subtraction, p1.y - subtraction };
    return sum;
}

static inline CGPoint CGPointSubtractPoint(CGPoint p1, CGPoint p2)
{
    CGPoint sum = { p1.x - p2.x, p1.y - p2.y };
    return sum;
}

static inline CGPoint CGPointDivide(CGPoint p1, float divisor)
{
    CGPoint sum = { p1.x / divisor, p1.y / divisor};
    return sum;
}

static inline CGPoint CGPointDivideWithPoint(CGPoint p1, CGPoint p2)
{
    CGPoint sum = { p1.x / p2.x, p1.y / p2.y };
    return sum;
}

static inline CGPoint CGPointMultiply(CGPoint p1, float multipler)
{
    CGPoint sum = { p1.x * multipler, p1.y * multipler};
    return sum;
}

static inline CGPoint CGPointMultiplyWithPoint(CGPoint p1, CGPoint p2)
{
    CGPoint sum = { p1.x * p2.x, p1.y * p2.y };
    return sum;
}

static inline CGPoint CGPointRotate(CGPoint p, float angle)
{
    if (angle == 0.0f)return CGPointMake(p.x, p.y);
    
    angle = DEGREES_TO_RADIANS(angle);
    
    double s = sin(angle);
    double c = cos(angle);
    
    return CGPointMake(p.x * c - p.y * s, p.x * s + p.y * c);//center ? point.add(center) : point;
}

static inline CGPoint CGPointRotateCenter(CGPoint p, float angle, CGPoint center)
{
    if (angle == 0.0f)return CGPointMake(p.x, p.y);
    
    angle = DEGREES_TO_RADIANS(angle);
    
    CGPoint point = CGPointSubtractPoint(p, center);
    
    double s = sin(angle);
    double c = cos(angle);
    
    point = CGPointMake(point.x * c - point.y * s, point.x * s + point.y * c);
    
    return CGPointAddPoint(point, center);
}

//normalize

//divide

static inline int GetRandomInt(int number)
{
	return (int)round(rand() % (int)number);
}

static inline int GetRandomIntRange(int Maxvalue, int MinValue)
{
	return GetRandomInt(Maxvalue - MinValue) + MinValue;
}

static inline float GetRandomFloat(float number)
{
	return ((float)arc4random() / ARC4RANDOM_MAX) * number;
}

static inline float GetRandomFloatRange(float Maxvalue, float MinValue)
{
	return GetRandomFloat((Maxvalue - MinValue)) + MinValue;
}

static inline CGPoint CalculateIntersectionB2Points(CGPoint P1, CGPoint P2, CGPoint P3, CGPoint P4)
{	
	float a = P1.x * P2.y - P1.y * P2.x;
	float b = P3.x * P4.y - P3.y * P4.x;
	float m = (P1.x - P2.x) * (P3.y - P4.y) - (P1.y - P2.y) * (P3.x - P4.x);

	float x = (a * (P3.x - P4.x) - (P1.x - P2.x) * b) / m;
	float y = (a * (P3.y - P4.y) - (P1.y - P2.y) * b) / m;
	
	return CGPointMake(x, y);
}

static inline float CalculateDiagonal(CGSize size)
{	
	return sqrt(size.width * size.width + size.height * size.height);
}

typedef struct
{
	CGPoint a;
	CGPoint b;
	
}CGLine;

static inline CGLine CGLineMake(CGPoint P1, CGPoint P2)
{
    CGLine ret;
	ret.a = P1;
	ret.b = CGPointSubtractPoint(P2, P1);
    
    return ret;
}

static inline CGLine CGLineVectorMake(CGPoint P1, CGPoint P2)
{
    CGLine ret;
	ret.a = P1;
	ret.b = P2;
    
    return ret;
}

static inline CGPoint CalculateIntersectionB2Lines(CGLine L1, CGLine L2)
{
    return CalculateIntersectionB2Points(L1.a, L1.b, L2.a, L2.b);
}

static inline float roundToNear(float number, float precision)
{
    return round(number / precision) * precision;
}
