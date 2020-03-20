//
//  SexPickerCell.m
//  MKInputViewDemo
//
//  Created by MAKE on 2018/7/18.
//  Copyright © 2018年 MAKE. All rights reserved.
//

#import "ClickPickerCell.h"
#import "Masonry.h"

NSString *const kSexPickerCellIdentifier = @"kSexPickerCellIdentifier";

@interface ClickPickerCell ()
@property (nonatomic, strong, readwrite) UIView *inputView;

@property (nonatomic,strong)NSArray * dataSource;
@end

@implementation ClickPickerCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView dataSource:(NSArray *)array
{
    ClickPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:kSexPickerCellIdentifier];
    if (cell == nil)
    {
        cell = [[ClickPickerCell alloc]init];
        cell.dataSource = array;
    }
    return cell;
}


- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSexPickerCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setNameText:@"* 性别"];
        self.detailTextLabel.text = @"";
    }
    return self;
}


- (void)setTitle:(NSString *)title{
    self.textLabel.text = title;
}
- (void)setDetailTitle:(NSString *)title{
    self.detailTextLabel.text = title;
}

- (void)setNameText:(NSString *)title{
    NSString *allString = title;
    NSString *agreeString = [NSString stringWithFormat:@"*"];
    
    NSAttributedString *string = [HNTools getAttributedString:allString withStringAttributedDic:@{NSForegroundColorAttributeName : [UIColor blackColor]} withSubString:agreeString withSubStringAttributeDic:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    [self.textLabel setAttributedText:string];
}
#pragma  mark - action

- (void)buttonClick:(UIButton *)sender{
    [self resignFirstResponder];
    if (!self.selectClickPickerBlock) { return; }
    
    self.selectClickPickerBlock(sender.tag-100 , self.dataSource[sender.tag-100]);
}

- (void)cancelButtonAction:(UIButton*)sender {
    [self resignFirstResponder];
}
#pragma  mark - 布局
- (void)masLayoutSubview
{
    NSInteger tag = 100;
    for (NSString *title in self.dataSource) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag =  tag;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, (48+1)*(tag-100), self.frame.size.width, 48);
        [self.inputView addSubview:button];
        tag ++;
    }
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView addSubview:cancelButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.inputView);
        make.height.mas_equalTo(48);
    }];
}


#pragma  mark - 懒加载
- (UIView *)inputView{
    if (!_inputView) {
        _inputView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.dataSource.count+1) * 48 + 20 )];
        _inputView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self masLayoutSubview];
    }
    return _inputView;
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}
@end
