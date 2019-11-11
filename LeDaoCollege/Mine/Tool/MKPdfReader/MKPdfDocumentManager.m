//
//  MKPdfDocumentManager.m
//  LeDaoCollege
//
//  Created by make on 2019/9/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import "MKPdfDocumentManager.h"
#import "MKDrawPDFView.h"

@interface MKPdfDocumentManager()
@property (nonatomic,assign,readwrite)CGPDFDocumentRef pdfDocument;
@property (nonatomic,assign,readwrite)NSInteger totalPage;
@end
@implementation MKPdfDocumentManager


+ (instancetype)getToLocalWith:(NSString *)name{
    NSString * pathName = SavePDFDocumenToPlisttPath(name);
    MKPdfDocumentManager *m = [NSKeyedUnarchiver unarchiveObjectWithFile:pathName];
    [m resetDocumentFormLocal];
    return m;
}
- (instancetype)initWithUrl:(NSURL *)url name:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
        [self configPdfWith:url];
        [self savePDFDataWith:url];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return  [self yy_modelInitWithCoder:aDecoder];
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}

- (void)configPdfWith:(NSURL *)url{
    CFURLRef pdfURL = CFURLCreateWithFileSystemPath(CFAllocatorGetDefault(), CFStringCreateWithCString(CFAllocatorGetDefault(), url.path.UTF8String, kCFStringEncodingUTF8), kCFURLPOSIXPathStyle, NO);
    CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
    self.pdfDocument = pdfDocument;
    self.totalPage = CGPDFDocumentGetNumberOfPages(_pdfDocument);
}



#pragma  mark - 管理文件归档到本地
- (void)saveToPlist {
    NSString * pathName = SavePDFDocumenToPlisttPath(self.name);
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSKeyedArchiver archiveRootObject:self toFile:pathName];
    });
}


#pragma  mark - PDF 二进制数据归档

/**
    从本地取出 CGPDFDocumentRef
 */
- (void)resetDocumentFormLocal{
    NSString * pathName = SavePDFDataPath(self.name);
    NSData *pdfData = [NSKeyedUnarchiver unarchiveObjectWithFile:pathName];
    CFDataRef dataRef = (__bridge_retained CFDataRef)(pdfData);
    CGDataProviderRef proRef = CGDataProviderCreateWithCFData(dataRef);
    CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithProvider(proRef);
    self.pdfDocument = pdfRef;
    
    CGDataProviderRelease(proRef);
    CFRelease(dataRef);
}
/**
  CGPDFDocumentRef 归档到本地
 */
- (void)savePDFDataWith:(NSURL *)url {
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSData *pdfData =[NSData dataWithContentsOfURL:url];
        NSString * pathName = SavePDFDataPath(self.name);
        [NSKeyedArchiver archiveRootObject:pdfData toFile:pathName];
    });
}

//用于网络pdf文件
- (CGPDFDocumentRef)pdfRefByDataByUrl:(NSString *)aFileUrl
{
    NSData *pdfData = [NSData dataWithContentsOfFile:aFileUrl];
    CFDataRef dataRef = (__bridge_retained CFDataRef)(pdfData);
    
    CGDataProviderRef proRef = CGDataProviderCreateWithCFData(dataRef);
    CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithProvider(proRef);
    
    CGDataProviderRelease(proRef);
    CFRelease(dataRef);
    
    return pdfRef;
}
@end
