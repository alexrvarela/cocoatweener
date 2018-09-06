# CocoaTweener

Easy to use animation engine for iOs, make more powerful and creative Apps.

![Logo](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/tweener.gif)

### Prerequisites

* Xcode with IOs 8.0+

## Installation

### Install using Cocoapods

To integrate install [Cocoa Pods](http://cocoapods.org/) using this gem:
```
$ gem install cocoapods
```

Now, add CocoaTweener to your Podfile
```
pod 'CocoaTweener', '~> 1.0.1'
```

To install dependencies run this command
```
pod install
```

### Install using Carthage

To integrate install [Carthage](https://github.com/Carthage/Carthage) with brew:
```
$ brew update
$ brew install carthage
```

Now, add CocoaTweener to your Cartfile
```
github "alexrvarela/CocoaTweener" ~> 1.0.1
```

To install dependencies run this command
```
$ carthage update
```
Finally, drag & drop CocoaTweenr.framework to your Xcode Project

### Install manually

Download, build and copy CocoaTweener.framework to your Xcode project.

## Usage

Import CocoaTweener engine to your project:

```objc
#import <CocoaTweener/CocoaTweener.h>
```

Animate any of these kinds of properties:
int, float, double, CGFloat, CGPoint, CGRect, UIColor

First set initial state:
```objc
    myView.alpha = 0.25f;
    myView.frame = CGRectMake(20.0f, 20.0f, 100.0f, 100.0f);
    myView.backgroundColor = [UIColor redColor];
```

Create and add simple Tween:

```objc
Tween* myTween = [[Tween alloc] init:myView
    duration:1.0f
    ease:kEaseOutQuad
    keys:@{@"alpha" : @1.0f,
           @"frame" : [NSValue valueWithCGRect:CGRectMake(20.0f, 20.0f, 280.0f, 280.0f)],
           @"backgroundColor" : [UIColor blueColor]
         }
];

[CocoaTweener addTween:myTween];
```

![Simple tween](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/simple-tween.gif)


Interact with your code using block handlers:

```objc
myTween.onStartHandler = ^{
    myView.backgroundColor = UIColor.greenColor;
};

myTween.onUpdateHandler = ^{
    [self doAnything];
};

myTween.onCompleteHandler = ^{
    myView.backgroundColor = UIColor.redColor;
};
```

![Handlers](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/handlers.gif)


You can pause, resume and remove tweens:

For all existing tweens:
```objc
[CocoaTweener pauseAllTweens];
[CocoaTweener resumeAllTweens];
[CocoaTweener removeAllTweens];
```

By target:
```objc
[CocoaTweener pauseTweens:myView];
[CocoaTweener resumeTweens:myView];
[CocoaTweener removeTweens:myView];
```

By specific properties of a target:
```objc
[CocoaTweener pauseTweens:myView keyPaths:@["backgroundColor", "alpha"];
[CocoaTweener resumeTweens:myView keyPaths:@["backgroundColor", "alpha"];
[CocoaTweener removeTweens:myView keyPaths:@["backgroundColor", "alpha"];
```

![Touch point](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/touch.gif)

### Timeline

Add a Tween or animate with Timeline?

It depends on what you want, a Tween only animates “to” desired value taking the current value of the property as origin, that allows your App to be more dynamic, each Tween is destroyed immediately after completing the animation.

Timeline stores “from” and “to” values of each Tween, contains a collection of reusable Tweens, to create Timeline and add Tweens:

```objc
Timeline* myTimeline = [[Timeline alloc] init];
[myTimeline addTween:myTween];
[myTimeline play];
```

You can interact with Timeline play modes, the default value is Play once, it stops when finished, to change Tmeline play mode:

Loop, repeat forever
```objc
myTimeline.playMode = kTimelinePlayModeLoop;
```
![Loop](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/timeline-play.gif)

Ping Pong, forward and reverse
```objc
myTimeline.playMode = kTimelinePlayModePingPong;
```

![Ping Pong](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/timeline-ping-pong.gif)

Perform parallax scrolling effects controlling your timeline with UIScrollView:

![Timeline scroll](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/tmeline-scroll.gif)


### TimelineInspector
You can use the Timeline inspector to debug  and edit Tweens 

![Visualize Tweens in real time!](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/tmeline-inspector.gif)

![Edit Tweens](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/timeline-editor.gif)

![Scale timeline editor](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/timeline-zoom.gif)

To create Timeline inspector:
```objc
TimelineInspector* myInspector = [[TimelineInspector alloc] init];
myInspector.timeline = myTimeline;
[self addSubview:myInspector];
```

### PDFImageView

Cut with the image dependency and easily import your vector assets using PDFImageView, forget to export to SVG and other formats iOs offers native support for PDF with CoreGraphics with this class that simply renders one pdf inside a UIImageView.

To load your asset named "bee.pdf" from App bundle:

```objc
PDFImageView* myAsset = [[PDFImageView alloc] init];
[myAsset loadFromBundle:@"bee"];
[myAsset addSubview:self.bee];
```

You can increase or reduce the size of your assets with a simple property:

```objc
myAsset.scale = 1.5f;
```

![Clouds](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/clouds.gif)

### Aims
Create more complex and impressive animations using Aims

![Aims](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/eye.gif)


### PathAim
Control motion with paths:

![Path aim](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/path.gif)

```objc
myPathAim = [[PathAim alloc] init];
myPathAim.tweenPath.path = myPath;
myPathAim.tweenPath.target = self.bee;
```

To change location at path change this property value:

```objc
myPathAim.interpolation = 0.5f;
```

And simply animate path interpolation:

```objc
myPathAim.interpolation = 0.0;

Tween* myTween = [[Tween alloc] init:myPathAim
                                  duration:1.5f
                                      ease:kEaseNone
                                      keys:@{ @"interpolation" : @1.0f }
                        ];

[CocoaTweener addTween:myTween];
```

You can export your paths to code from illustrator with this simple Script:
https://github.com/alexrvarela/generatePathCode


### RotationAim

Animate rotation of any view

![Rotation aim](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/rotation-aim.gif)

```objc
RotationAim* myRotationAim = [[RotationAim alloc] init];
myRotationAim.tweenPath.target = myView;
myRotationAim.angle = 90.0f;

Tween* myTween = [[Tween alloc] init:myRotationAim
                                  duration:1.5f
                                      ease:kEaseInOutCubic
                                      keys:@{ @"angle" : @180.0f }
                        ];

[CocoaTweener addTween:myTween];
```

### ArcAim
Create Arc animations

![Arc aims](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/orbits.gif)

```objc
RotationAim* myArcAim = [[RotationAim alloc] init];
myArcAim.tweenPath.target = myView;
myArcAim.radius = 100.0f;
myArcAim.arcAngle = 0.0f;

Tween* myTween = [[Tween alloc] init:myArcAim
                                  duration:1.5f
                                      ease:kEaseInOutCubic
                                      keys:@{ @"arcAngle" : @360.0f }
                        ];

[CocoaTweener addTween:myTween];
```

### StringAim
Animate text transitions

![String aims](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/text.gif)

```objc
StringAim* myStringAim = [[StringAim alloc] init];
myStringAim.from = @"hello";
myStringAim.to = @"hola";
myStringAim.target = myLabel;
myStringAim.interpolation = 0.0;

Tween* myTween = [[Tween alloc] init:myStringAim
                                  duration:1.5f
                                      ease:kEaseNone
                                      keys:@{ @"interpolation" : @1.0f }
                        ];

[CocoaTweener addTween:myTween];
```

Play with everything, combine different types of Aim:

![Mix different aims](https://raw.githubusercontent.com/alexrvarela/cocoatweener/master/Gifs/bb8.gif)

This library was created to give dynamism to the elements of the UI, if you are looking to make more complex animations I recommend you implement them using [Lottie](https://airbnb.design/lottie/).

## Contributions

This project has being migrated to Swift for future contributions and will no longer be maintained.

## Authors

* **Alejandro Ramírez Varela** - *Initial work* - [alexrvarela](https://github.com/alexrvarela)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Based on [Robert Penner](http://robertpenner.com)  [Easing functions](http://robertpenner.com/easing/)
* Based on [Tweener](https://github.com/zeh/tweener), AS3 Library by [Zeh Fernando](https://github.com/zeh), Nate Chatellier, Arthur Debert and Francis Turmel
Ported by Alejandro Ramirez Varela on 2012 and released as open source in 2018
