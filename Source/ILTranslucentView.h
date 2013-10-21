//
//  ILTranslucentView.h
//  ILTranslucentViewProject
//
//  Created by Ivo Leko on 10/11/13.
//  Copyright (c) 2013 Ivo Leko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ILTranslucentView : UIView

@property (nonatomic) BOOL translucent; //do you want blur effect? (default: YES)
@property (nonatomic) CGFloat translucentAlpha; //alpha of translucent  effect (default: 1)
@property (nonatomic) UIBarStyle translucentStyle; //blur style, Default or Black
@property (nonatomic, strong) UIColor *translucentTintColor; //tint color of blur, [UIColor clearColor] is default


@end
