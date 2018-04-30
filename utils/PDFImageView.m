//
//  PDFImageView.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/16/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import "PDFImageView.h"

@implementation PDFImageView

-(id)init
{
    self = [super init];
    {
        self.pdf = [[PDFImageRender alloc] init];
        _scale = 1.0f;
        _currentPage = 1;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:(CGRect)frame];
    {
        self.pdf = [[PDFImageRender alloc] init];
        _scale = 1.0f;
        _currentPage = 1;
    }
       return self;
}

-(void)loadFromBundle:(NSString*)filename{[self.pdf loadFromBundle:filename];[self updateImage];}
-(void)loadFile:(NSString*)path{[self.pdf loadFile:path];[self updateImage];}

-(void)setCurrentPage:(NSUInteger)page
{
    if (page <= self.pdf.pageCount && page > 0)
    {
        _currentPage = page;
        [self updateImage];
    }
}

-(void)setScale:(float)scale
{
    _scale = scale;
    [self updateImage];
}

-(void)updateImage
{
    if(self.pdf.document != NULL)
    {
        self.image = [self.pdf renderPage:self.currentPage scale:self.scale];
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                self.image.size.width,
                                self.image.size.height);
    }
}

@end
