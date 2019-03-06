//
//  EaseCurves.m
//  Examples
//
//  Created by Alejandro Ramirez Varela on 2/24/19.
//  Copyright © 2019 Alejandro Ramirez Varela. All rights reserved.
//

#import "EaseCurves.h"
#import <CocoaTweener/CocoaTweener.h>

@implementation EaseCurves

-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    
    if (self)
    {
        self.clipsToBounds = YES;
        self.easeList = @[
                          @{@"equations":@[Ease.inQuad,Ease.outQuad, Ease.inOutQuad, Ease.outInQuad],
                            @"name":@"Quad",
                            },
                          @{@"equations":@[Ease.inCubic,Ease.outCubic, Ease.inOutCubic, Ease.outInCubic],
                            @"name":@"Cubic",
                            },
                          @{@"equations":@[Ease.inQuart,Ease.outQuart, Ease.inOutQuart, Ease.outInQuart],
                            @"name":@"Quart",
                            },
                          @{@"equations":@[Ease.inQuint,Ease.outQuint, Ease.inOutQuint, Ease.outInQuint],
                            @"name":@"Quint",
                            },
                          @{@"equations":@[Ease.inSine,Ease.outSine, Ease.inOutSine, Ease.outInSine],
                            @"name":@"Sine",
                            },
                          @{@"equations":@[Ease.inExpo,Ease.outExpo, Ease.inOutExpo, Ease.outInExpo],
                            @"name":@"Expo",
                            },
                          @{@"equations":@[Ease.inCirc,Ease.outCirc, Ease.inOutCirc, Ease.outInCirc],
                            @"name":@"Circ",
                            },
                          @{@"equations":@[Ease.inElastic,Ease.outElastic, Ease.inOutElastic, Ease.outInElastic],
                            @"name":@"Elastic",
                            },
                          @{@"equations":@[Ease.inBack,Ease.outBack, Ease.inOutBack, Ease.outInBack],
                            @"name":@"Back",
                            },
                          @{@"equations":@[Ease.inBounce,Ease.outBounce, Ease.inOutBounce, Ease.outInBounce],
                            @"name":@"Bounce",
                            }
                          ];
        
        CGRect scrollBounds = self.bounds;
        scrollBounds.size.height = scrollBounds.size.height - 48.0f;
        self.scrollview = [[UIScrollView alloc] initWithFrame:scrollBounds];
        [self addSubview:self.scrollview];
        
        CGRect selBounds = self.bounds;
        selBounds.origin.y = self.bounds.size.height - 48.0f;
        self.selectorContainer = [[UIView alloc] initWithFrame:selBounds];
        [self addSubview:self.selectorContainer];
        
        //Button
        self.selectorButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                    0.0f,
                                                                    self.frame.size.width,
                                                                    48.0f)];
        [self.selectorButton addTarget:self action:@selector(showHide) forControlEvents:UIControlEventTouchUpInside];
        [self.selectorButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        self.selectorButton.backgroundColor = [UIColor colorWithRed:84.0 / 255.0 green:255 / 255.0 blue:194 / 255.0 alpha:1.0];
        [self.selectorContainer addSubview:self.selectorButton];

        
        self.easeSelector = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f,
                                                                           48.0f,
                                                                           self.frame.size.width,
                                                                           self.frame.size.height - 48.0f)];
        [self.selectorContainer addSubview:self.easeSelector];
        
        //Init array to retain instances
        self.buttons = [[NSMutableArray alloc] init];
        
        int i = 0;
        for (NSDictionary* dict in self.easeList)
        {
            //Create selector button
            UIButton* item = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,
                                                                              48.0f * i,
                                                                              self.frame.size.width,
                                                                              48.0f)];
            [item setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [item setTitle:[dict objectForKey:@"name"] forState:UIControlStateNormal];
            [item addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
            item.backgroundColor = UIColor.whiteColor;
            [self.easeSelector addSubview:item];
            
            //Add separator
            UIView* separator = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 47.0f, self.frame.size.width, 1.0f)];
            separator.backgroundColor = UIColor.blackColor;
            [item addSubview:separator];
            
            self.easeSelector.contentSize = CGSizeMake(self.frame.size.width,
                                                     item.frame.origin.y + item.frame.size.height);
            //Add to button list
            [self.buttons addObject:item];
            i++;
        }
        
        NSMutableArray<Equation>* equations = [[self.easeList objectAtIndex:0] objectForKey:@"equations"];
        NSString* name = [[self.easeList objectAtIndex:0] objectForKey:@"name"];
        [self.selectorButton setTitle:[NSString stringWithFormat:@"Ease: %@", name] forState:UIControlStateNormal];

        self.inspectors = [[NSMutableArray alloc] init];

        i = 0;
        
        float size = 250.0f;
        float extraSpace = 110.0f;
        float spacing = 20.0f;
        
        float totalHeigth = size + extraSpace;
        
        NSArray<NSString*>* types = @[@"In", @"Out", @"InOut",@"OutIn"];
        
        for (Equation equation in equations)
        {
            CurveInspector* inspector = [[CurveInspector alloc] initWithFrame:CGRectMake(spacing, spacing + i * (totalHeigth + spacing), self.frame.size.width - 40.0f, totalHeigth)];
            [self.scrollview addSubview:inspector];
            self.scrollview.contentSize = CGSizeMake(self.frame.size.width,
                                                     inspector.frame.origin.y + inspector.frame.size.height + spacing);
            
            inspector.ease = equation;
            inspector.label.text = types[i];
            [self.inspectors addObject:inspector];
            i++;
        }

        [self selectIndex:0];
    }
    return self;
}

-(void)showHide
{
    //Animate
    Tween* tween = [[Tween alloc] init:self.selectorContainer
                              duration:0.25f
                                  ease:Ease.outQuart
                                  keys:@{@"frame" : [NSValue valueWithCGRect:CGRectMake(0.0f, (self.selectorContainer.frame.origin.y == 0.0f) ? self.selectorContainer.frame.size.height - 48.0f : 0.0f, self.selectorContainer.frame.size.width, self.selectorContainer.frame.size.height)]
                                         }];
    [CocoaTweener addTween:tween];
}

-(void)select
{
    printf("select\n");
    for (UIButton* button in self.buttons)
    {
        if (button.highlighted == YES)
        {
            [self selectIndex:[self.buttons indexOfObject:button]];
            break;
        }
    }
}

-(void)selectIndex:(NSUInteger)index
{
    printf("select index:%i\n", (int)index);
    NSMutableArray<Equation>* equations = [[self.easeList objectAtIndex:index] objectForKey:@"equations"];
    NSString* name = [[self.easeList objectAtIndex:index] objectForKey:@"name"];
    [self.selectorButton setTitle:[NSString stringWithFormat:@"Ease: %@", name] forState:UIControlStateNormal];
    
    int i = 0;
    for (Equation equation in equations)
    {
        CurveInspector* inspector = [self.inspectors objectAtIndex:i];
        inspector.ease = equation;
        i++;
    }
    
    [self showHide];
}

@end
