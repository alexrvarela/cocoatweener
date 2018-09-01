//
//  ArcOrbits.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/22/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "ArcOrbits.h"

@implementation ArcOrbits

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:52.0f/255
                                               green:52.0f/255
                                                blue:71.0f/255
                                               alpha:1.0f];
        self.clipsToBounds = YES;
        
        self.background = [self addAsset:@"orbits-background"];
        self.sunFire = [self addAsset:@"little-sun-fire"];
        
        self.fireAim = [[RotationAim alloc] init];
        self.fireAim.target = self.sunFire;
        //timeline
        Timeline* timeline =  [[Timeline alloc] init];
        timeline.playMode = kTimelinePlayModeLoop;
        [timeline addTween:[[Tween alloc] init:self.fireAim
                                      duration:5.0f
                                          ease:kEaseNone
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:-360.0f], @"angle",
                                                nil]
                            ]];
        [timeline play];
        
        //sun
        self.sun = [self addAsset:@"little-sun"];
        
        //earth
        self.earth = [self addAsset:@"little-earth"];
        //aim
        self.earthAim = [self addArcAim:self.earth radius:100];
        self.earthAim.center = self.center;
        //timeline
        Timeline* timeline1 =  [[Timeline alloc] init];
        timeline1.playMode = kTimelinePlayModeLoop;
        [timeline1 addTween:[[Tween alloc] init:self.earthAim
                                      duration:5.0f
                                          ease:kEaseNone
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:360.0f], @"arcAngle",
                                                nil]
                            ]];
        [timeline1 play];
        
        //moon
        self.moon = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 3.0f, 3.0f)];
        self.moon.backgroundColor = [UIColor whiteColor];
        self.moon.layer.cornerRadius = 1.5f;
        //aim
        [self.earth addSubview:self.moon];
        self.moonAim = [self addArcAim:self.moon radius:11.0];
        self.moonAim.center = CGPointMake(self.earth.frame.size.width / 2.0f, self.earth.frame.size.height / 2.0f);
        //timeline
        Timeline* timeline2 =  [[Timeline alloc] init];
        timeline2.playMode = kTimelinePlayModeLoop;
        [timeline2 addTween:[[Tween alloc] init:self.moonAim
                                      duration:1.0f
                                          ease:kEaseNone
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:360.0f], @"arcAngle",
                                                nil]
                            ]];
        [timeline2 play];

        //mars
        self.mars = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10.0f, 10.0f)];
        self.mars.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:90.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
        self.mars.layer.cornerRadius = 5.0f;
        self.mars.center = self.center;
        [self addSubview:self.mars];
        //aim
        self.marsAim  = [self addArcAim:self.mars radius:150.0f];
        self.marsAim.center = self.center;
        //timeline
        Timeline* timeline3 =  [[Timeline alloc] init];
        timeline3.playMode = kTimelinePlayModeLoop;
        [timeline3 addTween:[[Tween alloc] init:self.marsAim
                                       duration:7.0f
                                           ease:kEaseNone
                                           keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [NSNumber numberWithFloat:360.0f], @"arcAngle",
                                                 nil]
                             ]];
        [timeline3 play];

        //jupyter
        self.jupyter = [self addAsset:@"little-jupyter"];
        //aim
        self.jupyterAim = [self addArcAim:self.jupyter radius:200];
        self.jupyterAim.center = self.center;
        //timeline
        Timeline* timeline4 =  [[Timeline alloc] init];
        timeline4.playMode = kTimelinePlayModeLoop;
        [timeline4 addTween:[[Tween alloc] init:self.jupyterAim
                                      duration:9.0f
                                          ease:kEaseNone
                                          keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithFloat:360.0f], @"arcAngle",
                                                nil]
                            ]];
        [timeline4 play];
        
        self.saturn = [self addAsset:@"little-saturn"];
        
        self.saturnAim = [self addArcAim:self.saturn radius:250];
        self.saturnAim.center = self.center;
        
        Timeline* timeline5 =  [[Timeline alloc] init];
        timeline5.playMode = kTimelinePlayModeLoop;
        [timeline5 addTween:[[Tween alloc] init:self.saturnAim
                                       duration:11.0f
                                           ease:kEaseNone
                                           keys:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [NSNumber numberWithFloat:360.0f], @"arcAngle",
                                                 nil]
                             ]];
        [timeline5 play];
    }
    
    return self;
}

-(ArcAim*)addArcAim:(UIView*)asset radius:(float)radius
{
    ArcAim* aim = [[ArcAim alloc] init];
    aim.target = asset;
    aim.radius = radius;
    
    return aim;
}
-(PDFImageView*)addAsset:(NSString*)name
{
    PDFImageView * asset = [[PDFImageView alloc] init];
    [asset loadFromBundle:name];
    [self addSubview:asset];
    asset.center = self.center;

    return asset;
}


@end
