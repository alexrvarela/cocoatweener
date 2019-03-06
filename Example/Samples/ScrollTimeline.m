//
//  ScrollTimeline.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 4/5/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "ScrollTimeline.h"
#import <CocoaTweener/CocoaTweener.h>

@implementation ScrollTimeline

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.backgroundColor = [UIColor colorWithRed:52.0f/255
                                               green:52.0f/255
                                                blue:71.0f/255
                                               alpha:1.0f];
        self.clipsToBounds = YES;
        
        self.timeline = [[Timeline alloc] init];
        
        self.scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollview.contentSize = CGSizeMake(self.scrollview.frame.size.width, 3000.0f);
        self.scrollview.contentInset = UIEdgeInsetsMake(-225, 0, -225, 0);
        self.scrollview.delegate = self;
        [self addSubview:self.scrollview];
        
        self.stars = [self addAsset:@"stars"];
        self.stars.center = self.center;
        
        self.comet = [self addAsset:@"comet"];
        self.comet.center = self.center;
        
        self.sun = [self addAsset:@"sun"];
        self.sun.scale = 4.0f;
        self.sun.center = self.center;
        
        self.earth = [self addAsset:@"earth"];
        self.earth.center = self.center;
        
        self.mars = [self addAsset:@"mars"];
        self.mars.center = self.center;
        
        self.jupyter = [self addAsset:@"jupyter"];
        self.jupyter.center = self.center;
        
        self.saturn = [self addAsset:@"saturn"];
        self.saturn.center = self.center;
        
        self.ufo = [self addAsset:@"ufo"];
        self.ufo.center = self.center;
        
        self.fire = [self addAsset:@"fire"];
        self.fire.center = self.center;
        
        self.rocket = [self addAsset:@"rocket"];
        self.rocket.center = self.center;
        
        self.moon = [self addAsset:@"moon"];
        self.moon.scale = 5.0f;
        self.moon.center = self.center;
        
        self.spaceman = [self addAsset:@"spaceman"];
        self.spaceman.center = self.center;
        
        CGRect nFrame;
        
        //ROCKET FIRE
        nFrame = self.fire.frame;
        nFrame.origin.y  = self.rocket.frame.origin.y + 24.0;
        self.fire.frame = nFrame;//initial value
        nFrame.origin.y  = self.rocket.frame.origin.y - self.fire.frame.size.height + 24.0;///destination value
        
        [self.timeline addTween:[[Tween alloc] init:self.fire
                                           duration:0.25f
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:0.8f
                                 ]];
        
        //SUN
        nFrame = self.sun.frame;
        nFrame.origin.y = - self.sun.frame.size.height + 300.0f;
        self.sun.frame = nFrame;
        nFrame.origin.y = - self.sun.frame.size.height;
        
        [self.timeline addTween:[[Tween alloc] init:self.sun
                                           duration:1.0
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:0.5
                                 ]];
        
        //MOON
        nFrame = self.moon.frame;
        nFrame.origin.y = self.frame.size.height;
        self.moon.frame = nFrame;//initial value
        nFrame.origin.y = -self.moon.frame.size.height;//destination value
        
        [self.timeline addTween:[[Tween alloc] init:self.moon
                                           duration:1.0f
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:1.5f
                                 ]];
        
        //HEARTH
        nFrame = self.earth.frame;
        nFrame.origin.y = self.frame.size.height;
        self.earth.frame = nFrame;//initial value
        nFrame.origin.y = -self.earth.frame.size.height;//destination value
        
        [self.timeline addTween:[[Tween alloc] init:self.earth
                                           duration:2.5f
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:0.85f
                                 ]];
        
        //SPACEMAN
        nFrame = self.spaceman.frame;
        nFrame.origin.y = self.frame.size.height + self.moon.frame.size.height * 0.75f;
        nFrame.origin.x += 200.0f;
        self.spaceman.frame = nFrame;//initial value
        
        nFrame.origin.x -= 100.0f;
        nFrame.origin.y = - self.moon.frame.size.height * 0.75f;//destination value
        
        [self.timeline addTween:[[Tween alloc] init:self.spaceman
                                           duration:1.0f
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:1.5f
                                 ]];
        
        //COMET
        nFrame = self.comet.frame;
        
        nFrame.origin.x = - self.comet.frame.size.width;
        nFrame.origin.y = self.frame.size.height / 2.0f + self.comet.frame.size.height;
        self.comet.frame = nFrame;//initial value
        
        nFrame.origin.x = self.frame.size.width;
        nFrame.origin.y = self.frame.size.height / 2.0f - self.comet.frame.size.height;//destination value
        
        [self.timeline addTween:[[Tween alloc] init:self.comet
                                           duration:1.0f
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:2.5f
                                 ]];
        
        
        //MARS
        nFrame = self.mars.frame;
        
        nFrame.origin.x = 54.0f;
        nFrame.origin.y = self.frame.size.height;
        self.mars.frame = nFrame;//initial value
        
        nFrame.origin.y = -self.mars.frame.size.height;//destination value
        
        [self.timeline addTween:[[Tween alloc] init:self.mars
                                           duration:1.0f
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:3.5f
                                 ]];
        
        //UFO
        nFrame = self.ufo.frame;
        
        nFrame.origin.x = self.frame.size.width;
        nFrame.origin.y -= 50.0f;
        self.ufo.frame = nFrame;//initial value
        
        nFrame.origin.x = -self.ufo.frame.size.width;//destination value
        nFrame.origin.y += 100.0f;
        
        [self.timeline addTween:[[Tween alloc] init:self.ufo
                                           duration:0.75f
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:4.5f
                                 ]];
        
        
        //JUPYTER
        nFrame = self.jupyter.frame;
        
        nFrame.origin.x = 54;
        nFrame.origin.y = self.frame.size.height;
        self.jupyter.frame = nFrame;//initial value
        
        nFrame.origin.y = -400.0f;//destination value
        
        [self.timeline addTween:[[Tween alloc] init:self.jupyter
                                           duration:1.5f
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:5.0f
                                 ]];
        
        //SATURN
        nFrame = self.saturn.frame;
        
        nFrame.origin.x = self.frame.size.width - 54 - self.saturn.frame.size.width;
        nFrame.origin.y = self.frame.size.height;
        self.saturn.frame = nFrame;//initial value
        
        nFrame.origin.y = -self.saturn.frame.size.height;//destination value
        
        [self.timeline addTween:[[Tween alloc] init:self.saturn
                                           duration:1.5f
                                               ease:Ease.none
                                               keys:@{
                                                      @"frame":[NSValue valueWithCGRect:nFrame],//Add key with destination value
                                                      }
                                              delay:7.0f
                                 ]];
        
        
    }
    
    return self;
}

//Control timeline with UIScrollView!
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float interpolation = self.scrollview.contentOffset.y / (self.scrollview.contentSize.height - self.scrollview.frame.size.height);
    [CocoaTweener setCurrentTime:interpolation * self.timeline.duration toTimeline:self.timeline];
}


-(void)freeze
{
    [self killScroll];
}

- (void)killScroll
{
    printf("kill scroll\n");
    CGPoint offset = self.scrollview.contentOffset;
    offset.x -= 1.0;
    offset.y -= 1.0;
    [self.scrollview setContentOffset:offset animated:NO];
    
    offset.x += 1.0;
    offset.y += 1.0;
    [self.scrollview setContentOffset:offset animated:NO];
}


-(PDFImageView*)addAsset:(NSString*)name
{
    PDFImageView * asset = [[PDFImageView alloc] init];
    [asset loadFromBundle:name];
    [self addSubview:asset];
    return asset;
}

@end
