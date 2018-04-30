//
//  PDFImageView.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 2/15/16.
//  Copyright © 2016 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFImageRender : NSObject

@property (strong, nonatomic) NSData* pdf;
@property (readonly) NSUInteger pageCount;
@property float scale;
@property CGPDFDocumentRef document;

-(UIImage*)renderPage:(NSUInteger)page scale:(CGFloat)scale;
-(void)loadFromBundle:(NSString*)filename;
-(void)loadFile:(NSString*)path;

@end
