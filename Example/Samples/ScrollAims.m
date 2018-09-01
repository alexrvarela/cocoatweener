//
//  ScrollAims.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 8/22/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "ScrollAims.h"

@implementation ScrollAims

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:222.0f/255.0f green:255.0f/255.0f blue:220.0f/255 alpha:1.0f];
        
        //Scrollview
        self.scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollview.contentSize = CGSizeMake(self.frame.size.width * 5.0f, self.frame.size.height);
        self.scrollview.delegate = self;
        [self addSubview:self.scrollview];
        
        //Sand background
        PDFImageView* pdfView = [[PDFImageView alloc] init];
        [pdfView loadFromBundle:@"sand"];

        //body
        self.body = [[PDFImageView alloc] init];
        [self.body loadFromBundle:@"bb8-body"];
        self.body.center =  self.center;
        [self addSubview:self.body];
        
        self.head = [[PDFImageView alloc] init];
        [self.head loadFromBundle:@"bb8-head"];
        self.head.center =  CGPointMake(self.center.x,
                                        self.center.y - ((self.body.frame.size.height + self.head.frame.size.height) / 2.0f) + 15.0f);
        //+ self.head.frame.size.height
        [self addSubview:self.head];
        
        self.sand = [[UIView alloc] initWithFrame:pdfView.bounds];
        self.sand.backgroundColor = [UIColor colorWithPatternImage:pdfView.image];
        self.sand.frame = CGRectMake(- self.frame.size.width,
                                     (self.frame.size.height + self.body.frame.size.height) / 2.0f,
                                     self.scrollview.contentSize.width + self.frame.size.width * 2.0f,
                                     (self.frame.size.height - self.body.frame.size.height) / 2.0f);
        
        [self.scrollview addSubview:self.sand];
        //head
        
        //Setup Aim
        self.rotationAim = [[RotationAim alloc] init];
        self.rotationAim.target = self.body;
        
        self.arcAim = [[ArcAim alloc] init];
        self.arcAim.target = self.head;
        self.arcAim.radius  = self.body.frame.size.width * 0.7;
        self.arcAim.orientToArc = YES;
        self.arcAim.arcAngleOffset = -90.0f;
        self.arcAim.angleOffset = -90.0f;
        self.arcAim.center  = self.center;
    }
    
    return self;
}

//Control timeline with UIScrollView!
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //Rotation
    self.rotationAim.distance = (self.scrollview.contentOffset.x / 537.0f);
    
    //Calculate velocity
    float velocity = self.scrollview.contentOffset.x - self.lastOffset;
    
    //Set max velocity
    float max = 35.0f;
    if (velocity < -max) velocity = -max;
    if (velocity > max) velocity = max;
    
    //Interpolate
    float interpolation = (velocity / max);
    
    //Arc angle
    self.arcAim.arcAngle = 45.0f * interpolation;
    
    self.lastOffset = self.scrollview.contentOffset.x;
}
@end
