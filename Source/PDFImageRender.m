//
//  PDFImageView.m
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/15/16.
//  Copyright © 2016 Alejandro Ramirez Varela. All rights reserved.
//

#import "PDFImageRender.h"

@implementation PDFImageRender

-(void)setPdf:(NSData *)pdf
{
    if (pdf != nil)
    {
        _pdf = pdf;
        printf("set pdf data\n");
        //TODO:validate file
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)self.pdf);
        _document = CGPDFDocumentCreateWithProvider(provider);
        CGDataProviderRelease(provider);
        
        //Get page count
        size_t pages = CGPDFDocumentGetNumberOfPages( _document );
        _pageCount = (NSUInteger)pages;
    }else
    {
        printf("Error invalid file\n");
    }
}

-(void)loadFromBundle:(NSString*)filename
{
    NSString* path = [[NSBundle mainBundle] pathForResource:filename ofType:@".pdf"];
    [self loadFile:path];
}

-(void)loadFile:(NSString*)path
{
    printf("load file\n");
    self.pdf = [[NSFileManager defaultManager] contentsAtPath:path];
}

//Get current page size
-(CGSize)getPageSize:(int)page
{
    if(!self.pdf)return CGSizeZero;
    CGPDFPageRef page1 = CGPDFDocumentGetPage(_document, page);
    CGRect mediaRect = CGPDFPageGetBoxRect(page1, kCGPDFCropBox);
    return mediaRect.size;
}

//TODO:add retina scale support
-(UIImage *)renderPage:(NSUInteger)page scale:(CGFloat)scale
{
    if(_document == NULL)return nil;
    
    //Add retina scale support
    CGFloat retinaScale = UIScreen.mainScreen.scale;
    scale *= retinaScale;
    
    //Get page
    CGPDFPageRef PDFPageRef = CGPDFDocumentGetPage(_document, page);
    
    //Get the rectangle of the cropped inside
    CGRect mediaRect = CGPDFPageGetBoxRect(PDFPageRef, kCGPDFCropBox);
    mediaRect.size.width *= scale;
    mediaRect.size.height *= scale;

    //Get graphic context
    UIGraphicsBeginImageContext(mediaRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    //Clear
    CGContextClearRect(context, mediaRect);

    //Flip y coordinates
    CGContextScaleCTM(context, scale, -scale);
    CGContextTranslateCTM(context, 0, -(mediaRect.size.height / scale));

    //Draw it and generate UIImage
    CGContextDrawPDFPage(context, PDFPageRef);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Return new image with retina scale
    return [UIImage imageWithCGImage:image.CGImage scale:retinaScale orientation:image.imageOrientation];
}

-(void)dealloc
{
    if(_document != NULL)CGPDFDocumentRelease(_document);
}
@end
