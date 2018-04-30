//
//  PDFImageView.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/16/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFImageRender.h"

@interface PDFImageView : UIImageView

@property (strong) PDFImageRender* pdf;
@property (nonatomic) NSUInteger currentPage;
@property (nonatomic) float scale;

-(void)loadFromBundle:(NSString*)filename;
-(void)loadFile:(NSString*)path;

@end
