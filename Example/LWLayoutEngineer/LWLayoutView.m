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
    }
    return self;
}

-(LWLayoutSpec *)layoutSpecThatFits:(CGSize)constrainedSize {
    LWYogaLayoutSpec *yogaLayout = [[LWYogaLayoutSpec alloc] init];
    yogaLayout.children = @[self.label, self.imageView];
    yogaLayout.layoutStyle.yogaStyle.flexDirection = LWFBDirectionRow;
    yogaLayout.layoutStyle.yogaStyle.alignItems = LWFBAlignItemCenter;
    
    return yogaLayout;
}

@end
