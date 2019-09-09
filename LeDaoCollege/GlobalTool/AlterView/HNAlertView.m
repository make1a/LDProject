//
//  HNAlertView.m
//  HNShop
//
//  Created by fengyang on 17/1/10.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNAlertView.h"
#import "UIView+HNExtension.h"

@interface HNAlertView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString   *title;// 提示标题
@property (nonatomic, strong) NSString   *contentStr;// 提示内容
@property (nonatomic, strong) NSArray    *titleArray;// 按钮标题数组


@property (nonatomic, strong) UIView       *bgView;
@property (nonatomic, strong) UIView       *centerView;

@property (nonatomic, strong) UITableView  *bottomView;
@end

@implementation HNAlertView


- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)contentStr whitTitleArray:(NSArray *)titleArray withType:(NSString *)type
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.title = title;
        self.contentStr = contentStr;
        self.titleArray = titleArray;
        self.type = type;
        
        [self setUI];
        
        self.backgroundColor = UIColorFromHEXA(0x333333, 0.3);
    }
    return self;
}

- (void)setUI
{
    
    if (self.titleArray == nil || self.type == nil) {
        
        return;
    }
    else
    {
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.bgView];
        
        if ([self.type isEqualToString:@"center"]) {
            
            [self createAlertViewCenter];
        }
        else if ([self.type isEqualToString:@"bottom"])
        {
            self.backgroundColor = UIColorFromHEXA(0x333333, 0.3);
            [self createAlertViewBottom];
        }
        else
        {
            
        }
    }
}

- (void)createAlertViewCenter
{
    _centerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-Handle_width(270))/2, (SCREEN_HEIGHT-Handle_height(120))/2, Handle_width(270), Handle_height(120))];
    _centerView.backgroundColor = [UIColor whiteColor];
    _centerView.layer.masksToBounds = YES;
    _centerView.layer.cornerRadius = Handle_width(10);
    [_bgView addSubview:_centerView];
    
    CGFloat titleHeight;
    CGFloat contentLabY;
    
    if ([self.title isEqualToString:@""] || self.title == nil) {
        titleHeight = 0;
        contentLabY = Handle_height(25);
    }
    else
    {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(Handle_width(20), Handle_height(15), _centerView.frame.size.width-Handle_width(20)*2, 20)];
        titleLab.text = self.title;
        titleLab.textColor = UIColorFromHEXA(0x666666, 1);
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:Handle_height(16)];
        [_centerView addSubview:titleLab];
        
        titleHeight = titleLab.frame.size.height;
        contentLabY = titleLab.frame.origin.y + titleLab.frame.size.height+Handle_height(10);
    }
    
    CGRect rect = [HNTools getStringFrame:self.contentStr withFont:15 withMaxSize:CGSizeMake(_centerView.frame.size.width-Handle_width(20)*2, MAXFLOAT)];
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake((_centerView.width-rect.size.width)/2, contentLabY, rect.size.width, rect.size.height)];
    contentLab.text = self.contentStr;
    contentLab.textColor = UIColorFromHEXA(0x666666, 1);
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.font = SystemFontSize(15);
    contentLab.numberOfLines = 0;
    [_centerView addSubview:contentLab];
    
    UIImageView *imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, contentLab.y+contentLab.height+Handle_height(25)-0.5, SCREEN_WIDTH, 0.5)];
    imageLine.backgroundColor = [UIColor blackColor];
    [_centerView addSubview:imageLine];
    
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.tag = 2000+i;
        titleBtn.backgroundColor = [UIColor clearColor];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = SystemFontSize(15);
        
        if (self.titleArray.count == 1) {
            titleBtn.frame = CGRectMake(_centerView.frame.size.width/self.titleArray.count*i, contentLab.frame.origin.y+contentLab.frame.size.height+Handle_height(25), _centerView.frame.size.width, Handle_height(45));
            [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else
        {
            titleBtn.frame = CGRectMake(_centerView.width/self.titleArray.count*i, contentLab.y+contentLab.height+Handle_height(25), _centerView.width/self.titleArray.count-0.5, Handle_height(45));
            if (i == 0) {
                [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            else
            {
                [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                UIImageView *centerLine = [[UIImageView alloc] initWithFrame:CGRectMake(_centerView.width/self.titleArray.count*i-0.5, titleBtn.y, 0.5, titleBtn.height)];
                centerLine.backgroundColor = [UIColor blackColor];
                [_centerView addSubview:centerLine];
            }
            
            if (self.titleArray.count > 2) {
                [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        
        [_centerView addSubview:titleBtn];
    }
    
    _centerView.frame = CGRectMake((SCREEN_WIDTH-Handle_width(270))/2, (SCREEN_HEIGHT-Handle_height(120))/2, Handle_width(270), contentLab.y+contentLab.height+Handle_height(25)+Handle_height(45));
}

- (void)createAlertViewBottom
{
    _bottomView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.titleArray.count*Handle_height(50)+Handle_height(10)+BOTTOM_SPACE_HEIGHT) style:UITableViewStyleGrouped];
    _bottomView.delegate = self;
    _bottomView.dataSource = self;
    _bottomView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bottomView.scrollEnabled = NO;
    
    [_bgView addSubview:_bottomView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.titleArray.count-1;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-Handle_width(150))/2, (Handle_height(50)-Handle_height(15))/2, Handle_width(150), Handle_height(15))];
    titleLab.font = SystemFontSize(15);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:titleLab];
    
    if (indexPath.section == 0) {
        
        // 在这里做个特殊的处理， 就为了显示退出登录视图的特殊样式
        if (self.isLoginOut)
        {
            titleLab.text = self.titleArray[indexPath.row];
            if (indexPath.row == 0)
            {
                titleLab.font = SystemFontSize(12);
                titleLab.textColor = UIColorFromHEXA(0x666666, 1);
            }
            else
            {
                titleLab.textColor = UIColorFromHEXA(0xffb108,1.0);
            }
        }
        else
        {
            titleLab.text = self.titleArray[indexPath.row];
            titleLab.textColor = UIColorFromHEXA(0x666666, 1);
        }
    }
    else
    {
        if (self.isLoginOut)
        {
            titleLab.text = [self.titleArray lastObject];
            titleLab.textColor = UIColorFromHEXA(0x666666, 1);
        }
        else
        {
            titleLab.text = [self.titleArray lastObject];
            titleLab.textColor = UIColorFromHEXA(0xB3B3B3,1.0);
        }
        
    }
    
    UIImageView *imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, Handle_height(50)-0.5, SCREEN_WIDTH, 0.5)];
    imageLine.backgroundColor = UIColorFromHEXA(0x666666, 1);
    [cell.contentView addSubview:imageLine];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Handle_height(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    else
    {
        return Handle_height(10);
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.myBlock) {
        
        [self dissmisAlert];
        
        if (indexPath.section == 0) {
            self.myBlock(indexPath.row);
        }
        else
        {
            self.myBlock(self.titleArray.count-1);
        }
    }
    
    [self dissmisAlert];
}

- (void)show
{
    if ([self.type isEqualToString:@"center"]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        [self exChangeOut:_centerView dur:0.5];
    }
    else if ([self.type isEqualToString:@"bottom"])
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        _weakself;
        [UIView animateWithDuration:0.25 animations:^{
            self->_bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-weakself.titleArray.count*Handle_height(50)-Handle_height(10)-BOTTOM_SPACE_HEIGHT, SCREEN_WIDTH, weakself.titleArray.count*Handle_height(50)+Handle_height(10)+BOTTOM_SPACE_HEIGHT);
        }];
    }
    else
    {
        
    }
}

- (void)dissmisAlert
{
    if ([self.type isEqualToString:@"center"]) {
        
        [self removeFromSuperview];
    }
    else if ([self.type isEqualToString:@"bottom"])
    {
        [UIView animateWithDuration:0.25 animations:^{
            self->_bottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_HEIGHT, self.titleArray.count*Handle_height(50)+Handle_height(10)+BOTTOM_SPACE_HEIGHT);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else
    {
        
    }
}

- (void)titleBtnClick:(UIButton *)btn
{
    if (self.myBlock) {
        self.myBlock(btn.tag-2000);
    }
    [self dissmisAlert];
}


- (void)showAlertView:(alertBlock)myBlock
{
    [self show];
    self.myBlock = myBlock;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _bgView;
}

- (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(_centerView.frame, point)) {
        
    }
    else
    {
        [self dissmisAlert];
    }
}


-(void)dissmissView{
    [self removeFromSuperview];
    if (self.myBlock)
    {
        self.myBlock(0);
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
