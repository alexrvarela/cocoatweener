//
//  TimelineBasic.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/12/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetSample.h"
#import "CocoaTweener.h"
#import "TimelineViewer.h"//TODO:rename to TimelineEditor

@interface TimelineBasic : UIView

@property (strong) AssetSample* asset1;
@property (strong) AssetSample* asset2;
@property (strong) AssetSample* asset3;
@property (strong) AssetSample* asset4;

@property (strong) Timeline* timeline;

@property float asset_3_rotation;//special property

@end
