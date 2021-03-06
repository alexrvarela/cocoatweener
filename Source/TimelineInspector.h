//
//  TimelineViewer.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/3/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timeline.h"

@interface TimelineInspector : UIView

@property (nonatomic) Timeline* timeline;

@property (strong) UIColor* uiColor;
@property (strong) UIView* line;
@property (strong) UIView* whitespace;
@property (strong) UIView* timeIndicator;
@property (strong) UILabel* timeLabel;
@property (strong) UIControl* playButton;
@property (strong) UIControl* playModeButton;
@property (strong) UIControl* directionButton;
@property (strong) UIControl* stopButton;
@property (strong) UIControl* logButton;
@property (strong) UIControl* hideButton;

@property float scale;
@property float backupScale;
@property float backupDuration;
@property float backupTimeDelay;
@property float touchArea;
@property int indexTouched;
@property int editMode;
//TODO:scroll timeline content
@property CGPoint contentOffset;

@end
