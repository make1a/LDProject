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
    NSTimeInterval _second;
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
        self.imageView.image = [UIImage imageNamed:@"seizeaseat_0"];
        self.textLabel.text = @"makemake";
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
    [self.imageView setCornerRadius:10];
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(17);
        make.top.mas_equalTo(self).mas_offset(5);
        make.width.mas_equalTo(PtWidth(112));
        make.height.mas_equalTo(PtHeight(64));
    }];
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(PtWidth(17));
        make.top.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self).mas_offset(PtWidth(-10));
    }];
    
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(PtWidth(17));
        make.top.mas_equalTo(self.textLabel.mas_bottom).mas_offset(PtHeight(8));
        make.height.mas_equalTo(PtHeight(18));
        make.width.mas_equalTo(PtWidth(50));
    }];
    
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.safePriceLabel];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.safePriceLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self.safePriceLabel);
    }];
    
    [self.safePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textLabel);
        make.top.mas_equalTo(self.tagLabel.mas_bottom).mas_offset(8);
    }];

    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagLabel.mas_right).offset(8);
        make.centerY.mas_equalTo(self.tagLabel);
        make.width.mas_equalTo(PtWidth(115));
        make.height.mas_equalTo(PtHeight(19));
    }];
}


- (void)timerRun:(NSTimer *)timer {
    if (_second > 0) {
        self.timeLabel.text = [NSString stringWithFormat:@"剩余时间:%@",[self timeToString]];
    }
    else {
        self.timeLabel.hidden = YES;
        
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        //时间到
        if (self.timeOverBlock) {
            self.timeOverBlock();
        }
    }
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
    _second = vaildTime - sec;
    return  [self ll_timeWithSecond:_second];
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
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    _second = timeInterval;
}
- (QMUILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:10] textColor:UIColorFromHEXA(0xFF009E65, 1)];
        _tagLabel.text = @"工具书";
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.layer.cornerRadius = PtHeight(18/2);
        _tagLabel.backgroundColor = [UIColor colorWithRed:214/255.0 green:242/255.0 blue:232/255.0 alpha:1.0];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tagLabel;
}
- (QMUILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[QMUILabel alloc]init];
        //中划线
        NSString *textStr = @"18.88";
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
        
        // 赋值
        _priceLabel.attributedText = attribtStr;
        _priceLabel.textColor = UIColorFromHEXA(0x999999, 1);
        _priceLabel.font = [UIFont systemFontOfSize:13];
    }
    return _priceLabel;
}
- (QMUILabel *)safePriceLabel {
    if (!_safePriceLabel) {
        _safePriceLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:PtHeight(15)] textColor:[UIColor redColor]];
        _safePriceLabel.text = @"18.88";
    }
    return _safePriceLabel;
}
- (QMUILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[QMUILabel alloc]init];
        [_timeLabel setCornerRadius:19/2.0];
        _timeLabel.backgroundColor = UIColorFromHEXA(0xFEEAEA, 1);
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = UIColorFromHEXA(0xF28484, 1);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}
@end
