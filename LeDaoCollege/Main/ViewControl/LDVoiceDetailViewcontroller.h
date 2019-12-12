//
//  LDVoiceDetailViewcontroller.h
//  LeDaoCollege
//
//  Created by Make on 2019/12/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "QMUICommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDVoiceDetailViewcontroller : QMUICommonViewController
@property (nonatomic,assign)BOOL isCollection;
@property (nonatomic,assign)NSString *s_id;
@property (nonatomic,copy)NSString * urlStrng;
@property (nonatomic,assign)BOOL isPlaying;

/// (1.资讯 2.音频 3.视频)
@property (nonatomic,copy)NSString * collectionType;

@property (nonatomic,copy)void (^didRefreshCollectionStateBlock)(BOOL isCollection);
@property (nonatomic,copy)void (^didRefreshPlayStateBlock)(BOOL isPlaying);
@end

NS_ASSUME_NONNULL_END
