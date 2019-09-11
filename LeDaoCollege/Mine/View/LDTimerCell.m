//
//  LDTimerCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDTimerCell.h"

NSString *const kLDTimerCellIdentifier = @"kLDTimerCellIdentifier";
@interface LDTimerCell ()
{
    NSTimer   *_timer;
    NSInteger _second;
}
@end

@implementation LDTimerCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDTimerCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDTimerCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDTimerCell alloc]init];
    }
    return cell;
}

- (instancetype)init{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLDTimerCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self configTimer];
        [self masLayoutSubview];
    }
    return self;
}

- (void)configTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
    //将定时器加入NSRunLoop，保证滑动表时，UI依然刷新
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)masLayoutSubview
{
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(5);
        make.right.mas_equalTo(self).mas_offset(5);
        make.width.mas_equalTo(PtWidth(112));
        make.height.mas_equalTo(PtHeight(64));
    }];
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(PtWidth(17));
        make.top.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self).mas_offset(PtWidth(-10));
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(PtWidth(17));
        make.top.mas_equalTo(self.textLabel.mas_bottom).mas_offset(PtHeight(8));
        make.height.mas_equalTo(PtHeight(18));
    }];
}

- (void)setConfigWithSecond:(NSInteger)second {
    _second = second;
    if (_second > 0) {
        self.textLabel.text = [self timeToString];
    } else {
        self.textLabel.text = @"00:00:00";
    }
}

- (void)timerRun:(NSTimer *)timer {
//    if (_second > 0) {
    self.textLabel.text = [self timeToString];
//        _second -= 1;
//    }
//    else {
//        self.textLabel.text = @"00:00:00";
//    }
}

//保证定时器被销毁
- (void)removeFromSuperview {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [super removeFromSuperview];
}

-(NSString *)timeToString{
    //现在的时间
    NSTimeInterval now = [NSDate date].timeIntervalSince1970;
    NSTimeInterval sec = now - self.timeInterval;
    NSTimeInterval vaildTime = 60 * 30;  //30分钟
    return  [self ll_timeWithSecond:vaildTime - sec];
}

//将秒数转换为字符串格式
- (NSString *)ll_timeWithSecond:(NSInteger)second {
    NSString *time;
    if (second < 60) {
        time = [NSString stringWithFormat:@"00:00:%02ld",(long)second];
    }
    else {
        if (second < 3600) {
            time = [NSString stringWithFormat:@"00:%02ld:%02ld",second/60,second%60];
        }
        else {
            time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",second/3600,(second-second/3600*3600)/60,second%60];
        }
    }
    return time;
}

- (void)dealloc {
    NSLog(@"cell释放");
}
#pragma  mark - GET SET
- (QMUILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:PtHeight(11)] textColor:UIColorFromHEXA(0xFF009E65, 1)];
        _tagLabel.text = @"工具书";
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.layer.cornerRadius = PtHeight(18/2);
        _tagLabel.backgroundColor = [UIColor colorWithRed:214/255.0 green:242/255.0 blue:232/255.0 alpha:1.0];
    }
    return _tagLabel;
}

@end
