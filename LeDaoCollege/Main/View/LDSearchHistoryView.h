//
//  LDSearchHistoryView.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/6.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDSearchHistoryView : UIView
@property (nonatomic,strong)NSArray * histroyArray;
@property (nonatomic,strong)NSArray * advanceArray;

@property (nonatomic,copy)void (^didSelectHistoryActionBlock)(NSString* title);
@property (nonatomic,copy)void (^didSelectAdvanceActionBlock)(NSString* title);

@end
