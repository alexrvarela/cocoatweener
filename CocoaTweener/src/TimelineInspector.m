//
//  TimelineViewer.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/3/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import "CocoaTweener.h"

//TODO: MOVE TO UTILS
#pragma mark - Math
#define DEGREES_TO_RADIANS(__DEGREE__) ((__DEGREE__) * M_PI / 180.0)
#define RADIANS_TO_DEGREES(__RADIAN__) ((__RADIAN__) * 180 / M_PI)

#define CONTROL_BAR_HEIGHT 40.0f
//#define CONTROL_BUTTON_WIDTH 40.0f
#define TIME_BAR_HEIGHT 35.0f
#define TWEEN_BAR_HEIGHT 25.0f


#define SOLID_GRAY  [UIColor colorWithRed:182.0f / 255.0f green:182.0f / 255.0f blue:182.0f / 255.0f alpha:1.0f]
#define TRANSPARENT_SOLID_GRAY  [UIColor colorWithRed:182.0f / 255.0f green:182.0f / 255.0f blue:182.0f / 255.0f alpha:0.5f]
#define TRANSPARENT_LIGHT_GRAY  [UIColor colorWithRed:182.0f / 255.0f green:182.0f / 255.0f blue:182.0f / 255.0f alpha:0.15f]

#define SOLID_RED  [UIColor colorWithRed:182.0f / 255.0f green:182.0f / 255.0f blue:182.0f / 255.0f alpha:1.0f]


static inline CGPathRef CGPathMakeRoundRect(CGRect rect, CGFloat cornerRadius)
{
    if (rect.size.width / 2 < cornerRadius)
        cornerRadius = rect.size.width / 2;
    if (rect.size.height / 2 < cornerRadius)
        cornerRadius = rect.size.height / 2;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL,
                      rect.origin.x,
                      rect.origin.y + rect.size.height - cornerRadius);
    
    CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y,
                        rect.origin.x + rect.size.width,
                        rect.origin.y,
                        cornerRadius);
    
    CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + rect.size.height,
                        cornerRadius);
    
    CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        cornerRadius);
    
    CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y,
                        cornerRadius);
    
    CGPathCloseSubpath(path);
    
    return path;
}

#import "TimelineInspector.h"
#import "Timeline.h"
#import "TweenControl.h"

@implementation TimelineInspector

-(UIBezierPath*)makePlayIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 6.9285f, origin.y - 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x + 6.9285f, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x - 6.9285f, origin.y + 8.0f)];
    [path closePath];
    
    return path;
}

-(UIBezierPath*)makePauseIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 6, origin.y - 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x - 6, origin.y + 8.0f)];
    
    [path moveToPoint:CGPointMake(origin.x + 6, origin.y - 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x + 6, origin.y + 8.0f)];
    
    return path;
}

-(UIBezierPath*)makeRewindIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 8, origin.y - 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x - 8, origin.y + 8.0f)];
    
    [path moveToPoint:CGPointMake(origin.x + 8.9285f, origin.y - 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x - 4.9285f, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x + 8.9285f, origin.y + 8.0f)];
    [path closePath];
    
    return path;
}
-(UIBezierPath*)makeStopIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 6, origin.y - 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x - 6, origin.y + 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x + 6, origin.y - 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x + 6, origin.y + 8.0f)];
    [path closePath];
    
    return path;
}

-(UIBezierPath*)makePlayOnceIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x, origin.y + 6)];
    [path addLineToPoint:CGPointMake(origin.x, origin.y - 6)];
    [path addLineToPoint:CGPointMake(origin.x - 3, origin.y - 6)];
    
    [path moveToPoint:CGPointMake(origin.x - 4, origin.y + 6)];
    [path addLineToPoint:CGPointMake(origin.x + 4, origin.y + 6)];
    
    return path;
}

-(UIBezierPath*)makeLoopIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x + 6, origin.y - 4)];
    [path addLineToPoint:CGPointMake(origin.x - 13, origin.y - 4)];
    [path addLineToPoint:CGPointMake(origin.x - 13, origin.y)];
    
    [path moveToPoint:CGPointMake(origin.x - 13 - 3.4635f, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x - 13, origin.y + 6)];
    [path addLineToPoint:CGPointMake(origin.x - 13 + 3.4635f, origin.y)];
    [path closePath];
    
    [path moveToPoint:CGPointMake(origin.x - 6, origin.y + 4)];
    [path addLineToPoint:CGPointMake(origin.x + 13, origin.y + 4)];
    [path addLineToPoint:CGPointMake(origin.x + 13, origin.y)];

    [path moveToPoint:CGPointMake(origin.x + 13 - 3.4635f, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x + 13, origin.y - 6)];
    [path addLineToPoint:CGPointMake(origin.x + 13 + 3.4635f, origin.y)];
    [path closePath];
    
    return path;
}

-(UIBezierPath*)makePingPongIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 10, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x + 10, origin.y)];
    
    [path moveToPoint:CGPointMake(origin.x + 10, origin.y - 3.4635f)];
    [path addLineToPoint:CGPointMake(origin.x + 16, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x + 10, origin.y + 3.4635f)];
    [path closePath];
    
    [path moveToPoint:CGPointMake(origin.x - 10, origin.y - 3.4635f)];
    [path addLineToPoint:CGPointMake(origin.x - 16, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x - 10, origin.y + 3.4635f)];
    [path closePath];
    
    return path;
}

-(UIBezierPath*)makeFowardIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 13, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x + 7, origin.y)];
    
    [path moveToPoint:CGPointMake(origin.x + 7, origin.y - 3.4635f)];
    [path addLineToPoint:CGPointMake(origin.x + 13, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x + 7, origin.y + 3.4635f)];
    [path closePath];
    
    return path;
}

-(UIBezierPath*)makeBackwardIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 7, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x + 13, origin.y)];
    
    [path moveToPoint:CGPointMake(origin.x - 7, origin.y - 3.4635f)];
    [path addLineToPoint:CGPointMake(origin.x - 13, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x - 7, origin.y + 3.4635f)];
    [path closePath];
    
    return path;
}

-(UIBezierPath*)makeLogIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 14.0f, origin.y - 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x - 2.0f, origin.y)];
    [path addLineToPoint:CGPointMake(origin.x - 14.0f, origin.y + 8.0f)];

    [path moveToPoint:CGPointMake(origin.x + 2.0f, origin.y + 8.0f)];
    [path addLineToPoint:CGPointMake(origin.x + 14.0f, origin.y + 8.0f)];
    
    return path;
}

-(UIBezierPath*)makeHideIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 12.0f, origin.y - 6.0f)];
    [path addLineToPoint:CGPointMake(origin.x, origin.y + 6.0f)];
    [path addLineToPoint:CGPointMake(origin.x + 12.0f, origin.y - 6.0f)];
    
    return path;
}

-(UIBezierPath*)makeShowIcon:(CGPoint)origin
{
    UIBezierPath* path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(origin.x - 12.0f, origin.y + 6.0f)];
    [path addLineToPoint:CGPointMake(origin.x, origin.y - 6.0f)];
    [path addLineToPoint:CGPointMake(origin.x + 12.0f, origin.y + 6.0f)];
    
    return path;
}

-(CAShapeLayer*)makeShapeLayer:(UIBezierPath*)path
{
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = SOLID_GRAY.CGColor;
    shapeLayer.borderWidth = 2.0f;
    shapeLayer.path = path.CGPath;
    shapeLayer.hidden = YES;
    
    return shapeLayer;
}

-(id)init
{
    float h = CONTROL_BAR_HEIGHT + TIME_BAR_HEIGHT + TWEEN_BAR_HEIGHT * 4.0f;
    
    CGRect frame = CGRectMake(0.0f,
                              UIScreen.mainScreen.bounds.size.height - h,
                              UIScreen.mainScreen.bounds.size.width,
                              h);
    
    printf("timeline viewer screen w : %f\n", UIScreen.mainScreen.bounds.size.width);
    printf("timeline viewer self w : %f\n", frame.size.width);
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.indexTouched = -1;
        //self.indexPresed = -1;
        self.scale = 100;
        
        //use UIScrollView to navigate
        UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(pinch:)];
        [self addGestureRecognizer:pinchRecognizer];
        
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(pan:)];
        
        panRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:panRecognizer];

        self.uiColor = [UIColor colorWithRed:116.0f / 255.0f green:244.0f / 255.0f blue:234.0f / 255.0f alpha:1.0f];//default
        
        //setup buttons
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                             CONTROL_BAR_HEIGHT,
                                                             1.0f,
                                                             self.frame.size.height - CONTROL_BAR_HEIGHT)];
        self.line.userInteractionEnabled = NO;
        self.line.backgroundColor = SOLID_GRAY;
        //self.line.hidden = YES;
        [self addSubview:self.line];
        
        self.whitespace = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                             CONTROL_BAR_HEIGHT + TIME_BAR_HEIGHT,
                                                             self.frame.size.width,
                                                             self.frame.size.height - CONTROL_BAR_HEIGHT - TIME_BAR_HEIGHT)];
        self.whitespace.userInteractionEnabled = NO;
        self.whitespace.backgroundColor = [UIColor colorWithRed:1.0f
                                                          green:1.0f
                                                           blue:1.0f
                                                          alpha:0.5f];
        //self.whitespace.hidden = YES;
        [self addSubview:self.whitespace];
        
        self.timeIndicator = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                      CONTROL_BAR_HEIGHT,
                                                                      15.0f,
                                                                      7.0f)];
        
        //Make polygon
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        shape.fillColor = SOLID_GRAY.CGColor;
        
        UIBezierPath* path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(0.0f, 0.0f)];
        [path addLineToPoint:CGPointMake(15.0f, 0.0f)];
        [path addLineToPoint:CGPointMake(7.5f, 7.0f)];
        
        shape.path = path.CGPath;
        
        [self.timeIndicator.layer addSublayer:shape];
        [self addSubview:self.timeIndicator];
        
        float buttonWidth =  (frame.size.width / 7.0f);//- 6.0f
        CGPoint centerShape = CGPointMake(buttonWidth / 2.0f, CONTROL_BAR_HEIGHT / 2.0f);
        
        //PLAY/PAUSE CONTROL
        self.playButton = [[UIControl alloc] initWithFrame:CGRectMake(0.0f,
                                                                      0.0f,
                                                                      buttonWidth,
                                                                      CONTROL_BAR_HEIGHT)];
        
        [self.playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
        self.playButton.backgroundColor = TRANSPARENT_LIGHT_GRAY;
        [self.playButton.layer addSublayer:[self makeShapeLayer:[self makePlayIcon:centerShape]]];
        [self.playButton.layer addSublayer:[self makeShapeLayer:[self makePauseIcon:centerShape]]];
        [[self.playButton.layer sublayers] objectAtIndex:0].hidden = NO;//show first by default
        [self addSubview:self.playButton];
        
        //PLAY MODE CONTROL
        self.playModeButton = [[UIControl alloc] initWithFrame:CGRectMake(buttonWidth + 1.0f,
                                                                          0.0f,
                                                                          buttonWidth,
                                                                          CONTROL_BAR_HEIGHT)];
        self.playModeButton.backgroundColor = TRANSPARENT_LIGHT_GRAY;
        [self.playModeButton addTarget:self action:@selector(playModeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.playModeButton.layer addSublayer:[self makeShapeLayer:[self makePlayOnceIcon:centerShape]]];
        [self.playModeButton.layer addSublayer:[self makeShapeLayer:[self makeLoopIcon:centerShape]]];
        [self.playModeButton.layer addSublayer:[self makeShapeLayer:[self makePingPongIcon:centerShape]]];
        
        [[self.playModeButton.layer sublayers] objectAtIndex:0].hidden = NO;//show first by default
        
        [self addSubview:self.playModeButton];
        
        //DIRECTION CONTROL
        self.directionButton = [[UIControl alloc] initWithFrame:CGRectMake((buttonWidth + 1.0f) * 2.0f,
                                                                          0.0f,
                                                                          buttonWidth,
                                                                          CONTROL_BAR_HEIGHT)];
        self.directionButton.backgroundColor = TRANSPARENT_LIGHT_GRAY;
        [self.directionButton addTarget:self action:@selector(playDirectionAction) forControlEvents:UIControlEventTouchUpInside];
        [self.directionButton.layer addSublayer:[self makeShapeLayer:[self makeFowardIcon:centerShape]]];
        [self.directionButton.layer addSublayer:[self makeShapeLayer:[self makeBackwardIcon:centerShape]]];
        
        [[self.directionButton.layer sublayers] objectAtIndex:0].hidden = NO;//show first by default
        
        [self addSubview:self.directionButton];

        
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((buttonWidth + 1.0f) * 3.0f,
                                                                   0.0f,
                                                                   buttonWidth,
                                                                   CONTROL_BAR_HEIGHT)];
        self.timeLabel.font = [UIFont fontWithName:@"Menlo-Regular" size:12.0f];
        //self.timeLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightBold];
        self.timeLabel.textColor = SOLID_GRAY;
        self.timeLabel.text = @"00:00";
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeLabel];
        
        //STOP/REWIND CONTROL
        self.stopButton = [[UIControl alloc] initWithFrame:CGRectMake((buttonWidth + 1.0f) * 4.0f,
                                                                      0.0f,
                                                                      buttonWidth,
                                                                      CONTROL_BAR_HEIGHT)];
        
        [self.stopButton addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
        self.stopButton.backgroundColor = TRANSPARENT_LIGHT_GRAY;
        [self.stopButton.layer addSublayer:[self makeShapeLayer:[self makeRewindIcon:centerShape]]];
        [self.stopButton.layer addSublayer:[self makeShapeLayer:[self makeStopIcon:centerShape]]];
        [[self.stopButton.layer sublayers] objectAtIndex:0].hidden = NO;//show first by default
        [self addSubview:self.stopButton];
        
        self.logButton = [[UIControl alloc] initWithFrame:CGRectMake((buttonWidth + 1.0f) * 5.0f,
                                                                     0.0f,
                                                                     buttonWidth,
                                                                     CONTROL_BAR_HEIGHT)];
        [self.logButton addTarget:self action:@selector(logAction) forControlEvents:UIControlEventTouchUpInside];
        [self.logButton.layer addSublayer:[self makeShapeLayer:[self makeLogIcon:centerShape]]];
        self.logButton.backgroundColor = TRANSPARENT_LIGHT_GRAY;
        [[self.logButton.layer sublayers] objectAtIndex:0].hidden = NO;//show first by default
        [self addSubview:self.logButton];
        
        self.hideButton = [[UIControl alloc] initWithFrame:CGRectMake((buttonWidth + 1.0f) * 6.0f,
                                                                       0.0f,
                                                                       buttonWidth,
                                                                       CONTROL_BAR_HEIGHT)];
        [self.hideButton addTarget:self action:@selector(hideAction) forControlEvents:UIControlEventTouchUpInside];
        [self.hideButton.layer addSublayer:[self makeShapeLayer:[self makeHideIcon:centerShape]]];
        [self.hideButton.layer addSublayer:[self makeShapeLayer:[self makeShowIcon:centerShape]]];
        self.hideButton.backgroundColor = TRANSPARENT_LIGHT_GRAY;
        [[self.hideButton.layer sublayers] objectAtIndex:0].hidden = NO;//show first by default
        [self addSubview:self.hideButton];

        self.contentOffset = CGPointZero;
    }
    return self;
}

-(void)setTimeline:(Timeline*)timeline
{
    //set need display
    if (_timeline != nil)
        [_timeline removeObserver:self forKeyPath:@"timeCurrent"];
    
    _timeline = timeline;
    
    if (timeline != nil)
    {
        printf("Add observer to timeline\n");
        [_timeline addObserver:self
               forKeyPath:@"timeCurrent"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];//observe time

        [_timeline addObserver:self
                    forKeyPath:@"state"
                       options:NSKeyValueObservingOptionNew
                       context:NULL];//observe state
        
        [_timeline addObserver:self
                    forKeyPath:@"playMode"
                       options:NSKeyValueObservingOptionNew
                       context:NULL];//observe play mode
        
        [_timeline addObserver:self
                    forKeyPath:@"reverse"
                       options:NSKeyValueObservingOptionNew
                       context:NULL];//observe play mode
        
        [self updatePlayButtonIcons];
    }
    else
    {
        return;//release timeline
    }
    
    //self.duration = _timeline.timeComplete;
    [self setNeedsDisplay];
    
    [self updateTimeLocation];
    [self updateTimeLabel];
    [self updatePlayButtonIcons];
    [self updatePlayModeIcons];
}

#pragma mark - Draw
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw Time Bar
    CGContextSaveGState(context);
    
    const CGFloat* components = CGColorGetComponents(self.uiColor.CGColor);
    CGContextSetFillColor(context, CGColorGetComponents([UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:0.25f].CGColor));

    CGContextFillRect(context, CGRectMake(0.0f,
                                          CONTROL_BAR_HEIGHT,
                                          self.frame.size.width,
                                          TIME_BAR_HEIGHT));
    CGContextRestoreGState(context);
    
    //Draw time bar gird with numbers as seconds
    /// UIScreen.mainScreen.scale
    int steps = roundf( (self.frame.size.width ) / self.scale );
    //printf("draw steps %i\n", steps);
    //TODO:catch content offset and set index to start
    
    CGContextSaveGState(context);
    CGContextSetFillColor(context, CGColorGetComponents(self.uiColor.CGColor));
    
    //draw lines
    for (int indexSecond = 0; indexSecond < steps + 1; indexSecond++)
    {
        //Translate
        if(indexSecond != 0)CGContextTranslateCTM(context, self.scale, 0.0f);
        //Set fill color
        
        //Add 1/2 line
        float lineHeigth = TIME_BAR_HEIGHT / 2.0f;
        CGContextFillRect(context, CGRectMake(0,
                                              CONTROL_BAR_HEIGHT + TIME_BAR_HEIGHT - lineHeigth,
                                              1.0f,
                                              lineHeigth));
        
        //Add 1/4 line
        lineHeigth = TIME_BAR_HEIGHT / 4.0f;
        CGContextFillRect(context, CGRectMake(self.scale / 2.0f,
                                              CONTROL_BAR_HEIGHT + TIME_BAR_HEIGHT - lineHeigth,
                                              1.0f,
                                              lineHeigth));
        
        //Add 1/8 lines
        lineHeigth = TIME_BAR_HEIGHT / 8.0f;
        CGContextFillRect(context, CGRectMake(self.scale / 4.0f,
                                              CONTROL_BAR_HEIGHT + TIME_BAR_HEIGHT - lineHeigth,
                                              1.0f,
                                              lineHeigth));
        
        CGContextFillRect(context, CGRectMake(self.scale / 2.0f + self.scale / 4.0f,
                                              CONTROL_BAR_HEIGHT + TIME_BAR_HEIGHT - lineHeigth,
                                              1.0f,
                                              lineHeigth));
    }
    
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    
    CGContextSetFillColor(context, CGColorGetComponents(self.uiColor.CGColor));
    CGContextTranslateCTM(context, - 6.0f, CONTROL_BAR_HEIGHT + 5.0f);
    
    //draw lines
    for (int indexSecond = 0; indexSecond < steps + 1; indexSecond++)
    {
        //Translate
        if(indexSecond != 0)CGContextTranslateCTM(context, self.scale, 0.0f);
        
        //Text
        CGPathRef textPath = [self getFontPathFromString:[NSString stringWithFormat:@"%i",(int) indexSecond] fontSize:12.0f];
        CGPathRef transformTextPath = [self flipPathVertically:textPath];
        
        //Add
        CGContextAddPath(context, transformTextPath);
        
        //Fill
        CGContextFillPath(context);
        CGPathRelease(textPath);
        CGPathRelease(transformTextPath);
    }
    CGContextRestoreGState(context);
    
    
    //Draw tweens
    CGContextSaveGState(context);
    
    //TODO:if timeline != nil, else display message "Add timeline to inspect"

    float base_y = CONTROL_BAR_HEIGHT + TIME_BAR_HEIGHT;//TODO: add offset

    for (int indexTween = 0; indexTween < [self.timeline.controllerList count] ; indexTween++)
    {
        TweenControl* tc = [self.timeline.controllerList objectAtIndex:indexTween];

        //Draw Tween bars
        UIColor* alphaColor = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:0.5f];
        CGContextSetFillColor(context, CGColorGetComponents( (indexTween == self.indexTouched)
                                                            ? alphaColor.CGColor
                                                            : self.uiColor.CGColor));
        
        CGPathRef path =  CGPathMakeRoundRect(CGRectMake(tc.tween.timeDelay * self.scale,
                                                         base_y + (TWEEN_BAR_HEIGHT * indexTween) + 1.0f,
                                                         tc.tween.duration * self.scale,
                                                         TWEEN_BAR_HEIGHT - 1.0f),
                                              5.0f);
        CGContextAddPath(context, path);
        CGContextFillPath(context);
        CGPathRelease(path);
    }
    
    CGContextRestoreGState(context);
    
    //draw time locations
    CGContextSaveGState(context);
    
    if (self.indexTouched != -1)
    {
        TweenControl* tc = [self.timeline.controllerList objectAtIndex:self.indexTouched];

        BOOL drawStart = (self.editMode == 0 || self.editMode == 2);
        BOOL drawEnd = (self.editMode == 0 || self.editMode == 1);

        //draw red lines!!!
        //set fill color 255 119 208
        CGContextSetFillColor(context, CGColorGetComponents([UIColor colorWithRed:255.0f / 255.0f
                                                                            green:119.0f / 255.0f
                                                                             blue:208.0f / 255.0f
                                                                            alpha:1.0f].CGColor));

        if(drawStart)
        {
            CGContextFillRect(context, CGRectMake(tc.tween.timeDelay * self.scale,
                                                  CONTROL_BAR_HEIGHT,
                                                  1.0f,
                                                  TIME_BAR_HEIGHT));
        }
        
        if(drawEnd)
        {
            CGContextFillRect(context, CGRectMake((tc.tween.timeDelay + tc.tween.duration) * self.scale,
                                                  CONTROL_BAR_HEIGHT,
                                                  1.0f,
                                                  TIME_BAR_HEIGHT));
        }
    }
    
    CGContextRestoreGState(context);
}

-(CGPathRef)getFontPathFromString:(NSString*)text fontSize:(float)fontSize
{
    UIFont* font = [UIFont fontWithName:@"Menlo-Regular" size:12.0f];
    CGMutablePathRef letters = CGPathCreateMutable();

    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, (CGFloat)font.pointSize, NULL);
    
    NSDictionary* attrs = [NSDictionary dictionaryWithObject:(__bridge id)ctFont forKey:(__bridge NSString*)kCTFontAttributeName];
    
    NSAttributedString *attrString = [[NSAttributedString alloc]
                                      initWithString:text
                                      attributes:attrs];
    CFRelease(ctFont);
    
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);

    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        CTRunRef CTRun = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef CTFont = CFDictionaryGetValue(CTRunGetAttributes(CTRun), kCTFontAttributeName);
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(CTRun); runGlyphIndex++)
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            
            CTRunGetGlyphs(CTRun, thisGlyphRange, &glyph);
            CTRunGetPositions(CTRun, thisGlyphRange, &position);
            
            CGPathRef letter = CTFontCreatePathForGlyph(CTFont, glyph, NULL);
            CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
            CGPathAddPath(letters, &t, letter);
            CGPathRelease(letter);
        }
    }
    
    CFRelease(line);
    
    return letters;
}

-(CGPathRef)flipPathVertically:(CGPathRef)path
{
    CGRect boundingBox = CGPathGetBoundingBox(path);
    
    CGMutablePathRef transformPath = CGPathCreateMutable();
    CGAffineTransform scale = CGAffineTransformMakeScale(1.0f, -1.0f);//flip CGPath vertically
    CGPathAddPath(transformPath, &scale, path);
    
    CGMutablePathRef translatePath = CGPathCreateMutable();
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, boundingBox.size.height);//translate to position
    CGPathAddPath(translatePath, &translate, transformPath);
    
    CGPathRelease(transformPath);
    
    return translatePath;
}

//catch touch events and interact with Timeline

#pragma mark - Gesture recognizer

-(void)pan:(UIPanGestureRecognizer*)recognizer
{
    //printf("pan action %i\n", (int)recognizer.state);
    
    CGPoint p = CGPointZero;
    CGPoint translation = [recognizer translationInView:self];
    
    if(recognizer.numberOfTouches > 0) p = [recognizer locationOfTouch:0 inView:self];
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        //printf("began\n");
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        
        if(self.touchArea == 0)
        {
            //printf("pan controls\n");
        }
        else if(self.touchArea == 1)
        {
            float time = (p.x / self.scale);
            [CocoaTweener setCurrentTime:time toTimeline:self.timeline];
        }
        else if(self.touchArea == 2)
        {
            if (self.indexTouched != -1)
            {

                TweenControl* tc = [self.timeline.controllerList objectAtIndex:self.indexTouched];
                
                if (self.editMode == 1)
                {
                    //change duration
                    float newDuration = self.backupDuration + (translation.x / self.scale);
                    tc.tween.duration = (newDuration < 0.1f) ? 0.1f : newDuration;
                }
                else if (self.editMode == 2)
                {
                    //change booth
                    float newDelay = self.backupTimeDelay + (translation.x / self.scale);
                    float newDuration = self.backupDuration - (translation.x / self.scale);
                    
                    if (newDelay < ((self.backupTimeDelay + self.backupDuration) - 0.1f))
                    {
                        tc.tween.timeDelay = (newDelay < 0.0f) ? 0.0f : newDelay;
                        tc.tween.duration = newDuration;
                    }
                    //(newDuration < self.backupTimeDelay) ? self.backupTimeDelay : newDuration;
                }
                else
                {
                    //change time delay
                    float newDelay = self.backupTimeDelay + (translation.x / self.scale);
                    tc.tween.timeDelay = (newDelay < 0.0f) ? 0.0f : newDelay;
                }
                
                tc.timeStart = tc.tween.timeDelay / [CocoaTweener getTimeScale];//refresh controller
                [CocoaTweener setCurrentTime:self.timeline.timeCurrent toTimeline:self.timeline];//update tween
                
                [self setNeedsDisplay];//redraw data
            }else
            {
                //printf("pan content offset\n");
            }
        }
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded ||
              recognizer.state == UIGestureRecognizerStateCancelled)
    {
        [self resetTouches];
    }
}

-(void)pinch:(UIPinchGestureRecognizer*)recognizer
{
    //printf("pinch action, scale : %f\n", (float)recognizer.scale);

    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        self.backupScale = self.scale;

    }else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        self.scale = roundf(self.backupScale * recognizer.scale);

        if(self.scale > 200.0f)self.scale = 200.0f;
        if(self.scale < 20.0f)self.scale = 20.0f;
        printf("current scale : %f\n", (float)self.scale);
        
        [self setNeedsDisplay];
        [self updateTimeLabel];
        [self updateTimeLocation];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded ||
            recognizer.state == UIGestureRecognizerStateCancelled)
    {
        //printf("pinch ended\n");
        [self resetTouches];
    }
}

#pragma mark - Touches

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //printf("touches began\n");
    
    if (!self.timeline)return;

    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    
    if (CGRectContainsPoint(CGRectMake(0.0f,
                                       0.0f,
                                       self.frame.size.width,
                                       CONTROL_BAR_HEIGHT),
                            p))
    {
        printf("touch controls\n");
        self.touchArea = 0;
    }
    else if (CGRectContainsPoint(CGRectMake(0.0f,
                                            CONTROL_BAR_HEIGHT,
                                            self.frame.size.width,
                                            TIME_BAR_HEIGHT),
                                 p))
    {
        //printf("touch timebar\n");
        self.touchArea = 1;
        
        
        if(self.timeline.isAdded)[self.timeline pause];
        //if(self.timeline.state != kTimelineStatePaused)[self.timeline pause];
        
        float time = (p.x / self.scale);
        [CocoaTweener setCurrentTime:time toTimeline:self.timeline];
    }
    else
    {
        printf("touch tween bars\n");
        self.touchArea = 2;
        
        float base_y = CONTROL_BAR_HEIGHT + TIME_BAR_HEIGHT;
        
        for (int indexTween = 0; indexTween < [self.timeline.controllerList count]; indexTween++)
        {
            TweenControl* tween = [self.timeline.controllerList objectAtIndex:indexTween];
            
            float edgeTolerance = 10.0f;
            
            if (CGRectContainsPoint(CGRectMake(tween.tween.timeDelay * self.scale - edgeTolerance,
                                               base_y + (TWEEN_BAR_HEIGHT * indexTween) + 1.0f,
                                               tween.tween.duration * self.scale + edgeTolerance * 2.0f,
                                               TWEEN_BAR_HEIGHT - 1.0f),
                                    p))
            {
                //printf("Tween index : %i touched!\n", indexTween);
                self.indexTouched = indexTween;
                
                //pause timeline if is playing
                if(self.timeline.isAdded)[self.timeline pause];
                self.backupTimeDelay = tween.tween.timeDelay;
                self.backupDuration = tween.tween.duration;
                //then, detect if touch is near to rieght corner
                
                float x_start = (tween.tween.timeDelay) * self.scale;
                float start_x_distance = p.x - x_start;
                
                float x_end = (tween.tween.timeDelay + tween.tween.duration) * self.scale;
                float end_x_distance = p.x - x_end;
                
                
                self.editMode = 0;//move
                
                if (end_x_distance < edgeTolerance &&  end_x_distance > - edgeTolerance)
                {
                    printf("edit end\n");
                    self.editMode = 1;
                }else if(start_x_distance < edgeTolerance &&  start_x_distance > - edgeTolerance)
                {
                    printf("edit start\n");
                    self.editMode = 2;
                }else
                {
                    printf("move\n");
                }

                break;
            }
        }
        
        if(self.indexTouched != -1)[self setNeedsDisplay];//redraw data
    }
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //printf("touches ended\n");
    [self resetTouches];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //printf("touch cancel\n");
    //[self resetTouches];
}

-(void)resetTouches
{
    //printf("reset touches\n");
    
    if (self.indexTouched != -1)
    {
        [self.timeline reset];
        [self setNeedsDisplay];//redraw data
    }
    
    self.indexTouched = -1;
}

#pragma mark - Button actions

-(void)playAction
{
    printf("\nplay action\n");
    //self.timeline.state == kTimelineStateInitial || self.timeline.state == kTimelineStateStarted
    if([self.timeline isAdded] && self.timeline.state != kTimelineStatePaused)
    {
        printf("pause\n");
        [self.timeline pause];
    }
    else
    {
        printf("play\n");
        [self.timeline play];
    }
}

-(void)stopAction
{
    printf("\nstop action\n");
    [self.timeline rewind];
}


-(void)updatePlayButtonIcons
{
    BOOL stopped = self.timeline.state == kTimelineStatePaused || self.timeline.state == kTimelineStateOver;
    //printf("stopped? %s\n", stopped ? "yes" : "no");
    [[self.playButton.layer sublayers] objectAtIndex:0].hidden = !stopped;
    [[self.playButton.layer sublayers] objectAtIndex:1].hidden = stopped;
}

-(void)updatePlayModeIcons
{
    for (int i = 0; i < self.playModeButton.layer.sublayers.count; i++)
    {
        [[self.playModeButton.layer sublayers] objectAtIndex:i].hidden = YES;
    }
    
    [[self.playModeButton.layer sublayers] objectAtIndex:(int)self.timeline.playMode].hidden = NO;
    
}

-(void)updateDirectionIcons
{
    [[self.directionButton.layer sublayers] objectAtIndex:0].hidden = self.timeline.reverse;
    [[self.directionButton.layer sublayers] objectAtIndex:1].hidden = !self.timeline.reverse;
}

-(void)playModeAction
{
    self.timeline.playMode = ((int)self.timeline.playMode < (int)kTimelinePlayModePingPong)
    ? (kTimelinePlayMode)((int)self.timeline.playMode + 1)
    : kTimelinePlayModeOnce;

    printf("play mode action %i\n", (int)self.timeline.playMode);
}

-(void)playDirectionAction
{
    self.timeline.reverse = !self.timeline.reverse;
    printf("play direction action %i\n", (int)self.timeline.playMode);
}

-(void)logAction
{
    printf("Log tweens code:\n");
    NSMutableString* logString = [[NSMutableString alloc] init];
    for(TweenControl* c in self.timeline.controllerList)
    {
        NSString* tweenName = [NSString stringWithFormat:@"tween%i", (int)[self.timeline.controllerList indexOfObject:c]];
        
        //initial values
        NSMutableString* values = [[NSMutableString alloc] initWithString:@""];

        //keys
        NSMutableString* keys = [[NSMutableString alloc] initWithString:@"NSDictionary *keys = @{\n"];;
        NSArray* allKeys = c.tween.keys.allKeys;
        
        for (int indexKey =  0; indexKey < allKeys.count; indexKey++)
        {
            //values
            
            //keys
            NSString* keyName = [allKeys objectAtIndex:indexKey];
            
            [values appendString:[NSString stringWithFormat:@"[target].%@ = %@\n",//todo format value
                                  keyName,
                                  [c.tween.keys valueForKey:keyName]]];
            
            
            [keys appendString:@"   "];
            [keys appendString:[NSString stringWithFormat:@"@\"%@\" : [NSValue valueWith:%@]\n",//todo format
                                keyName,
                                [c.tween.keys valueForKey:keyName]]];

        }
        
        [keys appendString:@"};\n"];
        
        //tween  params
        NSMutableString* tween = [[NSMutableString alloc] init];

        [logString appendString:[NSString stringWithFormat:@"Tween* %@ = [[Tween alloc] init:[target]\n\
    duration:?\n\
    ease:?\n\
    keys:keys\n\
    delay:?\n\
];\n", tweenName]];
        
        [logString appendString:values];
        [logString appendString:keys];
        [logString appendString:tween];


        //tween  params
    }

    printf("%s\n", logString.UTF8String);
}

-(void)hideAction
{
    printf("show/hide action\n");
    //backup frame
}

#pragma mark - Observers
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self.timeline)
    {
        if ([keyPath isEqualToString:@"timeCurrent"])
        {
            [self updateTimeLabel];
            [self updateTimeLocation];
        }
        else if ([keyPath isEqualToString:@"state"])
        {
            //printf("state changed\n");
            
            if (self.timeline.state == kTimelineStateInitial)
            {
                //printf("initial\n");
            }
            else if (self.timeline.state == kTimelineStateStarted)
            {
                //printf("started\n");
            }
            else if (self.timeline.state == kTimelineStatePaused)
            {
                //printf("paused\n");
            }
            else if (self.timeline.state == kTimelineStateOver)
            {
                //printf("over\n");
            }
            
            [self updatePlayButtonIcons];
        }
        else if ([keyPath isEqualToString:@"playMode"])
        {
            [self updatePlayModeIcons];
        }
        else if ([keyPath isEqualToString:@"reverse"])
        {
            [self updateDirectionIcons];
        }
    }
}

-(void)updateTimeLabel
{
    float time = (self.timeline.timeCurrent - self.timeline.timeStart);
    int seconds = (int)time % 60;
    int milliseconds = (int)(time * 100) - seconds * 100;
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d", seconds, milliseconds];
}

-(void)updateTimeLocation
{
    //update location
    float timeLocation = (self.timeline.timeCurrent - self.timeline.timeStart) * self.scale;
    
    self.timeIndicator.frame = CGRectMake(timeLocation - self.timeIndicator.frame.size.width / 2.0f,
                                          self.timeIndicator.frame.origin.y,
                                          self.timeIndicator.frame.size.width,
                                          self.timeIndicator.frame.size.height);
    
    self.line.frame = CGRectMake(timeLocation,
                                 self.line.frame.origin.y,
                                 self.line.frame.size.width,
                                 self.line.frame.size.height);
    
    self.whitespace.frame = CGRectMake(timeLocation,
                                       self.whitespace.frame.origin.y,
                                       self.whitespace.frame.size.width,
                                       self.whitespace.frame.size.height);
    
}

//TODO Log, parasm and code to copy and paste
//TODO: add pinch to zoom timeline, round data to 0.1 secs

-(void)dealloc
{
    if (self.timeline != nil)
    {
        [self removeObserver:self.timeline forKeyPath:@"timeCurrent"];
        [self removeObserver:self.timeline forKeyPath:@"state"];
        [self removeObserver:self.timeline forKeyPath:@"playMode"];
        [self removeObserver:self.timeline forKeyPath:@"reverse"];
    }
}

@end
