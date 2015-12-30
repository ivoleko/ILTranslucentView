//
//  ILTranslucentView.swift
//  ILTranslucentView
//
//  Created by Tomasz Szulc on 25/07/14.
//  http://github.com/tomkowz
//

/// Rewritten from https://github.com/ivoleko/ILTranslucentView

import UIKit

class ILTranslucentView: UIView {

    private var _translucent = true
    var translucent : Bool {
        set {
            _translucent = newValue
            if self.toolbarBG == nil {
                return
            }
            
            self.toolbarBG!.translucent = newValue
            
            if newValue {
                self.toolbarBG!.hidden = false
                self.toolbarBG!.barTintColor = self.ilColorBG
                self.backgroundColor = UIColor.clearColor()
            } else {
                self.toolbarBG!.hidden = true
                self.backgroundColor = self.ilColorBG
            }
        }
        get {
            return _translucent
        }
    }
    
    private var _translucentAlpha : CGFloat = 1.0
    internal var translucentAlpha : CGFloat {
        set {
            if newValue > 1 {
                _translucentAlpha = 1
            } else if (newValue < 0) {
                _translucentAlpha = 0
            } else {
                _translucentAlpha = newValue
            }
            
            if self.toolbarBG != nil {
                self.toolbarBG!.alpha = _translucentAlpha
            }
        }
        get {
            return _translucentAlpha
        }
    }
    
    var translucentStyle : UIBarStyle {
        set {
            if self.toolbarBG != nil {
                self.toolbarBG!.barStyle = newValue
            }
        }
        get {
            if self.toolbarBG != nil {
                return self.toolbarBG!.barStyle
            } else {
                return UIBarStyle.Default
            }
        }
    }
    
    private var _translucentTintColor = UIColor.clearColor()
    var translucentTintColor : UIColor {
        set {
            _translucentTintColor = newValue
            if (self.isItClearColor(newValue)) {
                self.toolbarBG!.barTintColor = self.ilDefaultColorBG
            } else {
                self.toolbarBG!.barTintColor = self.translucentTintColor
            }
        }
        get {
            return _translucentTintColor
        }
    }
    
    private var ilColorBG : UIColor?
    private var ilDefaultColorBG : UIColor?
    
    private var toolbarBG : UIToolbar?
    private var nonExistentSubview : UIView?
    private var toolbarContainerClipView : UIView?
    private var overlayBackgroundView : UIView?
    private var initComplete = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createUI()
    }
}

extension ILTranslucentView {
    private func createUI() {
        self.ilColorBG = self.backgroundColor
        
        self.translucent = true
        self.translucentAlpha = 1

        let _nonExistentSubview = UIView(frame: self.bounds)
        _nonExistentSubview.backgroundColor = UIColor.clearColor()
        _nonExistentSubview.clipsToBounds = true
        _nonExistentSubview.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleTopMargin]
        self.nonExistentSubview = _nonExistentSubview
        self.insertSubview(self.nonExistentSubview!, atIndex: 0)

        let _toolbarContainerClipView = UIView(frame: self.bounds)
        _toolbarContainerClipView.backgroundColor = UIColor.clearColor()
        _toolbarContainerClipView.clipsToBounds = true
        _toolbarContainerClipView.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleTopMargin]
        self.toolbarContainerClipView = _toolbarContainerClipView
        self.nonExistentSubview!.addSubview(self.toolbarContainerClipView!)

        var rect = self.bounds
        rect.origin.y -= 1
        rect.size.height += 1
        
        let _toolbarBG = UIToolbar(frame: rect)
        _toolbarBG.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.toolbarBG = _toolbarBG
        
        self.toolbarContainerClipView!.addSubview(self.toolbarBG!)
        self.ilDefaultColorBG = self.toolbarBG!.barTintColor
        
        let _overlayBackgroundView = UIView(frame: self.bounds)
        _overlayBackgroundView.backgroundColor = self.backgroundColor
        _overlayBackgroundView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.overlayBackgroundView = _overlayBackgroundView
        self.toolbarContainerClipView!.addSubview(self.overlayBackgroundView!)
        
        self.backgroundColor = UIColor.clearColor()
        self.initComplete = true
    }
    
    private func isItClearColor(color: UIColor) -> Bool {
        var red : CGFloat = 0.0
        var green : CGFloat = 0.0
        var blue : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return red == 0.0 && green == 0.0 && blue == 0.0 && alpha == 0.0
    }
    
    @objc override var frame : CGRect {
        set {
            if self.toolbarContainerClipView == nil {
                super.frame = newValue
                return
            }
            
            var rect = newValue
            rect.origin = CGPointZero
            
            let width = CGRectGetWidth(self.toolbarContainerClipView!.frame)
            if width > CGRectGetWidth(rect) {
                rect.size.width = width
            }

            let height = CGRectGetHeight(self.toolbarContainerClipView!.frame)
            if height > CGRectGetHeight(rect) {
                rect.size.height = height
            }
            
            self.toolbarContainerClipView!.frame = rect
            
            super.frame = newValue
            self.nonExistentSubview!.frame = self.bounds
        }
        get {
            return super.frame
        }
    }
    
    @objc override var bounds : CGRect {
        set {
            var rect = newValue
            rect.origin = CGPointZero
            
            let width = CGRectGetWidth(self.toolbarContainerClipView!.bounds)
            if width > CGRectGetWidth(rect) {
                rect.size.width = width
            }
            
            let height = CGRectGetHeight(self.toolbarContainerClipView!.bounds)
            if height > CGRectGetHeight(rect) {
                rect.size.height = height
            }
            
            self.toolbarContainerClipView!.bounds = rect
            super.bounds = newValue
            self.nonExistentSubview!.frame = self.bounds
        }
        get {
            return super.bounds
        }
    }
    
    @objc override var backgroundColor : UIColor! {
        set {
            if self.initComplete {
                self.ilColorBG = newValue
                if (self.translucent) {
                    self.overlayBackgroundView!.backgroundColor = newValue
                    super.backgroundColor = UIColor.clearColor()
                }
            } else {
                super.backgroundColor = self.ilColorBG
            }
        }
        get {
            return super.backgroundColor
        }
    }
    
    @objc override var subviews : [UIView] {
        if self.initComplete {
            var array = super.subviews as [UIView]
            
            var index = 0
            for view in array {
                if view == self.nonExistentSubview {
                    break
                }
                index++
            }
            
            if index < array.count {
                array.removeAtIndex(index)
            }
            
            return array
        } else {
            return super.subviews
        }
    }
    
    override func sendSubviewToBack(view: UIView)  {
        if self.initComplete {
            self.insertSubview(view, aboveSubview: self.toolbarContainerClipView!)
        } else {
            super.sendSubviewToBack(view)
        }
    }
    
    override func insertSubview(view: UIView, atIndex index: Int) {
        if self.initComplete {
            super.insertSubview(view, atIndex: index + 1)
        } else {
            super.insertSubview(view, atIndex: index)
        }
    }
    
    override func exchangeSubviewAtIndex(index1: Int, withSubviewAtIndex index2: Int)  {
        if self.initComplete {
            super.exchangeSubviewAtIndex((index1 + 1), withSubviewAtIndex: (index2 + 1))
        } else {
            super.exchangeSubviewAtIndex(index1, withSubviewAtIndex: index2)
        }
    }
}
