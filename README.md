ILTranslucentView (iOS)
=================

ILTranslucentView is a little subclass of UIView that provide native iOS 7+ blur (translucent) effect.
It can be used on all iOS devices in real time without any performance problems. It also supports smooth UIView animation of color, frame, alpha etc.

## How to use it

 - add ILTranslucentView.h and ILTranslucentView.m from Source folder to your project
 - use it as normal UIView but with additional methods/propertiers:

```objective-c
    ILTranslucentView *translucentView = [[ILTranslucentView alloc] initWithFrame:CGRectMake(0, 0, 250, 150)];
    [self.view addSubview:translucentView]; //that's it :)
    
    //optional:
    translucentView.translucentAlpha = 1;
    translucentView.translucentStyle = UIBarStyleDefault;
    translucentView.translucentTintColor = [UIColor clearColor];
    translucentView.backgroundColor = [UIColor clearColor];
```

Using Swift, sending this subview to the back and [including ObjC in our Swift project][objc-swift],

[objc-swift]:http://stackoverflow.com/a/24102433/1141256

```swift
    // sizing background image correctly
    UIGraphicsBeginImageContext(self.view.frame.size)
    UIImage(named: "bw.png").drawInRect(self.view.bounds)
    var resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext()
    self.view.backgroundColor = UIColor(patternImage:resizedImage)
        
    // blurry background like control and notification center
    var translucentView = ILTranslucentView(frame: self.view.frame)
    translucentView.translucentAlpha = 0.78
    self.view.insertSubview(translucentView, atIndex: 0)
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
It works but without translucent effect. Behaves as a regular UIView. Try using some opacity on backgroundColor instead.

## Storyboard or XIB

In Identity Inspector just add Custom Class: ILTranslucentView. 

<p align="center" >
  <img src="https://raw.github.com/ivoleko/ILTranslucentView/master/StoryboardOrXIB.png" alt="ILTranslucentView_examples" title="ILTranslucentView_examples">
</p>
