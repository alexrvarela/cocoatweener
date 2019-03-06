//
//  TweenParameters.h
//  CocoaTweener
//
//  Created by Alejandro Ramirez Varela on 3/1/18.
//  Copyright © 2018 Alejandro Ramirez Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ease.h"

typedef void (^TweenHandler)(void);

@interface Tween : NSObject

@property float duration;
@property (strong) id target;
@property (strong) NSDictionary* keys;
@property Equation ease;

@property (strong) TweenHandler onStartHandler;
@property (strong) TweenHandler onUpdateHandler;
@property (strong) TweenHandler onCompleteHandler;
@property (strong) TweenHandler onOverwriteHandler;

@property float timeDelay;
@property BOOL overwrite;

//init with required parameters (4)
-(id)init:(id)target duration:(float)duration ease:(Equation)ease keys:(NSDictionary*)keys;

//init with delay
-(id)init:(id)target duration:(float)duration ease:(Equation)ease keys:(NSDictionary*)keys delay:(float)delay;

//init with delay and completion handler
-(id)init:(id)target duration:(float)duration ease:(Equation)ease keys:(NSDictionary*)keys delay:(float)delay completion:(TweenHandler)completion;

@end
