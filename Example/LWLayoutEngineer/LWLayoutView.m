//
//  LWLayoutView.m
//  LWLayoutEngineer_Example
//
//  Created by sunshinelww on 2018/3/29.
//  Copyright © 2018年 13517248639@163.com. All rights reserved.
//

#import "LWLayoutView.h"
#import "UIView+LWLayoutable.h"
#import "LWLayoutView.h"
#import "LWYogaLayoutSpec.h"
#import "LWLayoutStyle.h"
#import "YogaStyle.h"

@interface LWLayoutView ()

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UITextView *descriptionView;

@end

@implementation LWLayoutView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.text = @"Hello kitty!!";
        self.label.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.label];
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"image_icon"];
        [self addSubview:self.imageView];
        self.descriptionView = [[UITextView alloc] init];
        self.descriptionView.text = @"要有最朴素的生活和最遥远的梦想，即使明日天寒地冻、路遥马亡 .";
        self.descriptionView.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.descriptionView];

    }
    return self;
}

-(LWLayoutSpec *)layoutSpecThatFits:(CGSize)constrainedSize {
    LWYogaLayoutSpec *yogaLayout = [[LWYogaLayoutSpec alloc] init];
    yogaLayout.children = @[self.label, self.imageView];
    [self.label.layoutStyle configYogaLayout:^(YogaStyle * _Nonnull yogaStyle) {
        yogaStyle.marginRight = YGPointValue(10);
    }];
    [yogaLayout.layoutStyle configYogaLayout:^(YogaStyle * _Nonnull yogaStyle) {
        yogaStyle.flexDirection = LWFBDirectionRow;
        yogaStyle.justifyContent = LWFBJustifyContentCenter;
        yogaStyle.alignItems = LWFBAlignItemCenter;
    }];
    LWYogaLayoutSpec *contentYogaLayout = [[LWYogaLayoutSpec alloc] init];
    contentYogaLayout.children = @[yogaLayout, self.descriptionView];
    [contentYogaLayout.layoutStyle configYogaLayout:^(YogaStyle * _Nonnull yogaStyle) {
        yogaStyle.flexDirection = LWFBDirectionColumn;
        yogaStyle.alignItems = LWFBAlignItemCenter;
        yogaStyle.justifyContent = LWFBJustifyContentCenter;
        yogaStyle.width = YGPointValue(300);
        yogaStyle.height = YGPointValue(300);
    }];
    return contentYogaLayout;
}

@end
