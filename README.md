# CocoaTweener

Easy to use animation engine for iOs, make more powerfull and creative Apps.

## Getting Started

![Add interaction](https://media.giphy.com/media/ZwEe1iL6OGfYivKWPW/giphy.gif) ![Animate backgrounds](https://media.giphy.com/media/ccVEctPrQ3JopWsyBH/giphy.gif)![Control animation with UIScrollView](https://media.giphy.com/media/1oDtjQUOSYucCEE6st/giphy.gif)

### Prerequisites

* Xcode with IOs 9.0+

### Installing

Install manually

Download and copy the entire folder named "src"  to your Xcode project.

Install using Cocoapods

```
In process...
```

Install using Carthage

```
In process...
```

### Usage

Import CocoaTweener engine to your project:

```objc
#import "CocoaTweener.h"
```

Create and add simple Tween:

```objc
Tween* myTween = [[Tween alloc] init:view
    duration:1.0f
    ease:kEaseOutQuad
    keys:[NSDictionary dictionaryWithObjectsAndKeys:
    [NSValue valueWithCGPoint:p], @"center",
    nil]
    delay:0.f
];

[CocoaTweener addTween:myTween];
```

Interact with your code using handlers:

```objc
myTween.onStartHandler = ^{
    [self onStartExample];
};

myTween.onUpdateHandler = ^{
    [self onUpdateExample];
};

myTween.onCompleteHandler = ^{
    [self onCompleteExample];
};
```

Create TImeline:

```objc

Timeline* myTimeline = [[Timeline alloc] init];

[myTimeline addTween:myTween];
[myTimeline play];

```

Interact with Timeline play modes:

Loop
```objc
myTimeline.playMode = kTimelinePlayModeLoop;
```
![Loop](https://media.giphy.com/media/B1RCOCUIXywTNENBjy/giphy.gif)


Ping Pong
```objc
myTimeline.playMode = kTimelinePlayModePingPong;
```
![Ping Pong](https://media.giphy.com/media/1YbC1Xy83ivhAlq4Go/giphy.gif)


Use timeline inspector for debbug:

[Visualize Tweens in real time!](https://media.giphy.com/media/3j1iQSKi0BgsB0M8Ox/giphy.gif)
[Edit Tweens](https://media.giphy.com/media/3DsN9STG4a4JvIjN41/giphy.gif)
[Scale timeline editor](https://media.giphy.com/media/5h7sdGhWiH4bLDMHOL/giphy.gif)

Create Timeline inspector:

```objc
TimelineInspector* myInspector = [[TimelineInspector alloc] init];
[self addSubview:myInspector];

myInspector.timeline = myTimeline;
```

## Contributions
This project has being migrated to Swift for future contributions and will no longer be maintained.

## Authors
* **Alejandro Ramírez Varela** - *Initial work* - [alexrvarela](https://github.com/alexrvarela)


## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Based on [Robert Penner](http://robertpenner.com)  [Easing functions](http://robertpenner.com/easing/)

* Based on [Tweener](https://github.com/zeh/tweener), AS3 Library by Zeh Fernando, Nate Chatellier, Arthur Debert and Francis Turmel
Ported by Alejandro Ramirez Varela on 2012 and released as open source in 2018
