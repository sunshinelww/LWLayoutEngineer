//
//  LWViewController.m
//  LWLayoutEngineer
//
//  Created by 13517248639@163.com on 03/26/2018.
//  Copyright (c) 2018 13517248639@163.com. All rights reserved.
//

#import "LWViewController.h"
#import "UIView+LWLayoutable.h"
#import "LWLayoutView.h"
#import "LWYogaLayoutSpec.h"
#import "YogaStyle.h"

@interface LWViewController ()

@property (nonatomic, strong)LWLayoutView *contentView;

@end

@implementation LWViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.contentView = [[LWLayoutView alloc] init];
    [self.view addSubview:self.contentView];
    self.contentView.layoutStyle.preferredSize = CGSizeMake(200, 300);
    __weak typeof(self) weakSelf = self;
    self.view.layoutSpecBlock = ^LWLayoutSpec *(CGSize constrainedSize) {
        LWYogaLayoutSpec *layoutSpec = [[LWYogaLayoutSpec alloc] init];
        [layoutSpec.layoutStyle configYogaLayout:^(YogaStyle * _Nonnull yogaStyle) {
            yogaStyle.flexDirection = LWFBDirectionRow;
            yogaStyle.justifyContent = LWFBJustifyContentCenter;
            yogaStyle.alignItems = LWFBAlignItemCenter;
        }];

        layoutSpec.child = weakSelf.contentView;
        return layoutSpec;
    };
}


- (void)viewWillLayoutSubviews {
    LWLayout * layout = [self.view layoutThatFits:self.view.frame.size];
    
}

@end
