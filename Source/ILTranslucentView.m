//
//  ILTranslucentView.m
//  ILTranslucentViewProject
//
//  Created by Ivo Leko on 10/11/13.
//  Copyright (c) 2013 Ivo Leko. All rights reserved.
//

#import "ILTranslucentView.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface ILTranslucentView () {
    UIView *nonexistentSubview; //this is first child view of ILTranslucentView. It is not available trough "Managing the View Hierarchy" methods.
    UIView *toolbarContainerClipView; //view which contain UIToolbar as child subview
    UIToolbar *toolBarBG; //this is empty toolbar which we use to produce blur (translucent) effect
    UIView *overlayBackgroundView; //view over toolbar that is responsive to backgroundColor property
    BOOL initComplete;
}

@property (nonatomic, copy) UIColor *ilColorBG; //backGround color
@property (nonatomic, copy) UIColor *ilDefaultColorBG; //default Apple's color of UIToolbar

@end

@implementation ILTranslucentView
@synthesize translucentAlpha = _translucentAlpha;


#pragma mark - Initalization
- (id)initWithFrame:(CGRect)frame //code
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder { //XIB
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void) createUI {
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        _ilColorBG = self.backgroundColor; //get background color of view (can be set trough interface builder before)
        self.ilDefaultColorBG=toolBarBG.barTintColor; //Apple's default background color
        
        _translucent=YES;
        _translucentAlpha=1;
        
        // creating nonexistentSubview
        nonexistentSubview = [[UIView alloc] initWithFrame:self.bounds];
        nonexistentSubview.backgroundColor=[UIColor clearColor];
        nonexistentSubview.clipsToBounds=YES;
        nonexistentSubview.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [self insertSubview:nonexistentSubview atIndex:0];
        
        //creating toolbarContainerClipView
        toolbarContainerClipView = [[UIView alloc] initWithFrame:self.bounds];
        toolbarContainerClipView.backgroundColor=[UIColor clearColor];
        toolbarContainerClipView.clipsToBounds=YES;
        toolbarContainerClipView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [nonexistentSubview addSubview:toolbarContainerClipView];
        
        //creating toolBarBG
        //we must clip 1px line on the top of toolbar
        CGRect rect= self.bounds;
        rect.origin.y-=1;
        rect.size.height+=1;
        toolBarBG =[[UIToolbar alloc] initWithFrame:rect];
        toolBarBG.frame=rect;
        toolBarBG.autoresizingMask= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [toolbarContainerClipView addSubview:toolBarBG];
        
    
        
        
        //view above toolbar, great for changing blur color effect
        overlayBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        overlayBackgroundView.backgroundColor = self.backgroundColor;
        overlayBackgroundView.autoresizingMask= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [toolbarContainerClipView addSubview:overlayBackgroundView];
        
        
        [self setBackgroundColor:[UIColor clearColor]]; //view must be transparent :)
        initComplete=YES;
    }
    
}

#pragma mark - Configuring a View’s Visual Appearance



- (BOOL) isItClearColor: (UIColor *) color {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    if (red!=0 || green != 0 || blue != 0 || alpha != 0) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void) setFrame:(CGRect)frame {
    
    
    //     - Setting frame of view -
    // UIToolbar's frame is not great at animating. It produces lot of glitches.
    // Because of that, we never actually reduce size of toolbar"
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        CGRect rect = frame;
        rect.origin.x=0;
        rect.origin.y=0;
        
        if (toolbarContainerClipView.frame.size.width>rect.size.width) {
            rect.size.width=toolbarContainerClipView.frame.size.width;
        }
        if (toolbarContainerClipView.frame.size.height>rect.size.height) {
            rect.size.height=toolbarContainerClipView.frame.size.height;
        }
        
        toolbarContainerClipView.frame=rect;
        
        [super setFrame:frame];
        [nonexistentSubview setFrame:self.bounds];
    }
    else
        [super setFrame:frame];
}

- (void) setBounds:(CGRect)bounds {
    
    //     - Setting bounds of view -
    // UIToolbar's bounds is not great at animating. It produces lot of glitches.
    // Because of that, we never actually reduce size of toolbar"
    
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        CGRect rect = bounds;
        rect.origin.x=0;
        rect.origin.y=0;
        
        if (toolbarContainerClipView.bounds.size.width>rect.size.width) {
            rect.size.width=toolbarContainerClipView.bounds.size.width;
        }
        if (toolbarContainerClipView.bounds.size.height>rect.size.height) {
            rect.size.height=toolbarContainerClipView.bounds.size.height;
        }
        
        toolbarContainerClipView.bounds=rect;
        [super setBounds:bounds];
        [nonexistentSubview setFrame:self.bounds];
    }
    else
        [super setBounds:bounds];
    
}


- (void) setTranslucentStyle:(UIBarStyle)translucentStyle {
    toolBarBG.barStyle=translucentStyle;
}
- (UIBarStyle) translucentStyle {
    return toolBarBG.barStyle;
}


- (void) setTranslucentTintColor:(UIColor *)translucentTintColor {
   
    _translucentTintColor = translucentTintColor;
    
    //tint color of toolbar
    if ([self isItClearColor:translucentTintColor])
        [toolBarBG setBarTintColor:self.ilDefaultColorBG];
    else
        [toolBarBG setBarTintColor:translucentTintColor];
}

- (void) setBackgroundColor:(UIColor *)backgroundColor {
    
    //changing backgroundColor of view actually change tintColor of toolbar
    if (initComplete) {
        
        self.ilColorBG=backgroundColor;
        if (_translucent) {
            overlayBackgroundView.backgroundColor = backgroundColor;
            [super setBackgroundColor:[UIColor clearColor]];
        }
        else {
            [super setBackgroundColor:self.ilColorBG];
        }
        
    }
    else
        [super setBackgroundColor:backgroundColor];
}

- (void) setTranslucent:(BOOL)translucent {
    
    //enabling and disabling blur effect
    _translucent=translucent;
    
    toolBarBG.translucent=translucent;
    if (translucent) {
        toolBarBG.hidden=NO;
        [toolBarBG setBarTintColor:self.ilColorBG];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    else {
        toolBarBG.hidden=YES;
        [self setBackgroundColor:self.ilColorBG];
    }
}

- (void) setTranslucentAlpha:(CGFloat)translucentAlpha {
    //changing alpha of toolbar
    
    if (translucentAlpha>1)
        _translucentAlpha=1;
    else if (translucentAlpha<0)
        _translucentAlpha=0;
    else
        _translucentAlpha=translucentAlpha;
    
    toolBarBG.alpha=translucentAlpha;

}


#pragma mark - Managing the View Hierarchy

- (NSArray *) subviews {

    // must exclude nonexistentSubview
    
    if (initComplete) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[super subviews]];
        [array removeObject:nonexistentSubview];
        return (NSArray *)array;
    }
    else {
        return [super subviews];
    }
    
}
- (void) sendSubviewToBack:(UIView *)view {
    
    // must exclude nonexistentSubview

    if (initComplete) {
        [self insertSubview:view aboveSubview:toolbarContainerClipView];
        return;
    }
    else
        [super sendSubviewToBack:view];
}
- (void) insertSubview:(UIView *)view atIndex:(NSInteger)index {
    
    // must exclude nonexistentSubview
    
    if (initComplete) {
        [super insertSubview:view atIndex:(index+1)];
    }
    else
        [super insertSubview:view atIndex:index];

}
- (void) exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2 {
    
    // must exclude nonexistentSubview
    
    if (initComplete)
        [super exchangeSubviewAtIndex:(index1+1) withSubviewAtIndex:(index2+1)];
    else
        [super exchangeSubviewAtIndex:(index1) withSubviewAtIndex:(index2)];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
