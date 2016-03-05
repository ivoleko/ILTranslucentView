[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

ILTranslucentView (iOS, Objective-C, Swift)
=================

ILTranslucentView is a little subclass of UIView that provide native iOS 7+ blur (translucent) effect.
It can be used on all iOS devices in real time without any performance problems. It also supports smooth UIView animation of color, frame, alpha etc.

For iOS 8.0+ use Apple's UIVisualEffectView:
https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIVisualEffectView/

## How to use it

 - add ILTranslucentView.h and ILTranslucentView.m from Source folder to your project
 - use it as normal UIView but with additional methods/propertiers:

```objective-c
    #import "ILTranslucentView-Swift.h"

    ILTranslucentView *translucentView = [[ILTranslucentView alloc] initWithFrame:CGRectMake(0, 0, 250, 150)];
    [self.view addSubview:translucentView]; //that's it :)
    
    //optional:
    translucentView.translucentAlpha = 1;
    translucentView.translucentStyle = UIBarStyleDefault;
    translucentView.translucentTintColor = [UIColor clearColor];
    translucentView.backgroundColor = [UIColor clearColor];

```

```swift
    import ILTranslucentView
    
    var view = ILTranslucentView(frame: CGRectMake(0, 0, 250, 150))
    self.view.addSubview(view)
    
    view.translucentAlpha = 1
    view.translucentStyle = UIBarStyle.Default
    view.translucentTintColor = UIColor.clearColor()
    view.backgroundColor = UIColor.clearColor()
```

#### translucentAlpha
The translucent's alpha value. The value of this property is a floating-point number in the range 0.0 to 1.0, where 0.0 represents view without translucent effect and 1.0 represents maximum translucent effect.  
<i>Notice: If translucentAlpha is not set to 1.0, view may lose blur effect.</i>

#### translucentStyle
ILTranslucentView uses UIToolbar to provide translucent effect. This property specifies its appearance.

#### translucentTintColor
The tint color to apply to the translucent color.

#### backgroundColor
For iOS 6-, this is the view’s background color. For iOS 7+ it represents background color of layer above translucent layer.


## Example:
<p align="center" >
  <img src="https://raw.github.com/ivoleko/ILTranslucentView/master/ScreenShot%20example.png" alt="ILTranslucentView_examples" title="ILTranslucentView_examples">
</p>

## iOS 6 and lower?
It works but only Objective-C class and without translucent effect. Behaves as a regular UIView. Try using some opacity on backgroundColor instead.


## Storyboard or XIB

In Identity Inspector just add Custom Class: ILTranslucentView. 

<p align="center" >
  <img src="https://raw.github.com/ivoleko/ILTranslucentView/master/StoryboardOrXIB.png" alt="ILTranslucentView_examples" title="ILTranslucentView_examples">
</p>
