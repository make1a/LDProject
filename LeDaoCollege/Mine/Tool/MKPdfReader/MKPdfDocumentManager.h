//
//  MKPdfDocumentManager.h
//  LeDaoCollege
//
//  Created by make on 2019/9/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPdfDocumentManager : NSObject<NSCoding>
@property (nonatomic,assign,readonly)CGPDFDocumentRef pdfDocument;
@property (nonatomic,copy)NSString * name;

@property (nonatomic,assign,readonly)NSInteger totalPage;
@property (nonatomic,assign)NSInteger currentPage;


/**
 从本地取出管理h数据

 @param name 文件名称
 @return self
 */
+ (instancetype)getToLocalWith:(NSString *)name;
- (instancetype)initWithUrl:(NSURL *)url name:(NSString *)name;
- (void)saveToPlist;
@end

NS_ASSUME_NONNULL_END
