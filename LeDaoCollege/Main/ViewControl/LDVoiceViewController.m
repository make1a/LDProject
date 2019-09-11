//
//  LDVoiceViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVoiceViewController.h"
#import "LDTagView.h"
@interface LDVoiceViewController ()
@property (nonatomic,strong)LDTagView * tagView;
@end

@implementation LDVoiceViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tagView];
}
#pragma mark - event response
- (void)didSelectTagAction{
    
}

#pragma mark - private method
#pragma mark - get and set

- (LDTagView *)tagView {
    if (!_tagView) {
        _tagView = [[LDTagView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tagView.titles = @[@"Helps", @"Maintain", @"Liver", @"Health", @"Function", @"Supports", @"Healthy", @"Fat"];
    }
    return _tagView;
}
@end
