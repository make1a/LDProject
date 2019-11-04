//
//  LDWebViewViewController.h
//  LeDaoCollege
//
//  Created by make on 2019/11/3.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDWebViewViewController : UIViewController
@property (nonatomic,copy)NSString * urlStrng;
@property (nonatomic,assign)BOOL isCollection;
@property (nonatomic,assign)NSString *s_id;

/// (1.资讯 2.音频 3.视频)
@property (nonatomic,copy)NSString * collectionType;

@property (nonatomic,copy)void (^didRefreshCollectionStateBlock)(BOOL isCollection);

@end

NS_ASSUME_NONNULL_END
