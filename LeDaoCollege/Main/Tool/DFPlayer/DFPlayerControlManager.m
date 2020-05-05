//
//  DFPlayerControlManager.m
//  DFPlayer
//
//  Created by ihoudf on 2017/7/20.
//  Copyright © 2017年 ihoudf. All rights reserved.
//

#import "DFPlayerControlManager.h"
#import "DFPlayer.h"
#import <objc/runtime.h>
#import "DFPlayerTool.h"
#import "DFPlayerLyricsTableview.h"
#import <MediaPlayer/MediaPlayer.h>

static NSString * key_ActionBlock = @"key_ActionBlock";
#define WeakPointer(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface UIButton (EBlock)
@property(copy, nonatomic) void(^ _Nullable handleButtonActionBlock)(UIButton * _Nullable sender);
@end

@implementation UIButton(EBlock)

- (void)setHandleButtonActionBlock:(void (^)(UIButton * _Nullable))handleButtonActionBlock{
    objc_setAssociatedObject(self, (__bridge const void *)key_ActionBlock, handleButtonActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (handleButtonActionBlock) {
        [self addTarget:self action:@selector(actionHandler) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)actionHandler{
    if (self.handleButtonActionBlock) {
        self.handleButtonActionBlock(self);
    }
}

-  (void (^)(UIButton * _Nullable))handleButtonActionBlock{
    return objc_getAssociatedObject(self, (__bridge const void *)key_ActionBlock);
}

@end


#pragma mark - DFPlayerSlider

@interface DFPlayerSlider : UISlider
@property (nonatomic, assign) CGFloat trackHeight;
@end

@implementation DFPlayerSlider

- (CGRect)trackRectForBounds:(CGRect)bounds{
    return CGRectMake(0, (CGRectGetHeight(self.frame)-self.trackHeight) / 2, CGRectGetWidth(self.frame), self.trackHeight);
}

@end

#pragma mark -  DFPlayer控制管理器

//KEY
NSString * const DFStateKey          = @"state";
NSString * const DFBufferProgressKey = @"bufferProgress";
NSString * const DFProgressKey       = @"progress";
NSString * const DFCurrentTimeKey    = @"currentTime";
NSString * const DFTotalTimeKey      = @"totalTime";

#define DFPlayerSrcName(file) [@"DFPlayer.bundle" stringByAppendingPathComponent:file]
#define DFPlayerFrameworkSrcName(file) [@"Frameworks/DFPlayer.framework/DFPlayer.bundle" stringByAppendingPathComponent:file]
#define DFPlayerImage(file) [UIImage imageNamed:DFPlayerSrcName(file)] ? :[UIImage imageNamed:DFPlayerFrameworkSrcName(file)]

#define DFPlayer_playImage      DFPlayerImage(@"dfplayer_play")
#define DFPlayer_pauseImage     DFPlayerImage(@"dfplayer_pause")
#define DFPlayer_airplayImage   DFPlayerImage(@"dfplayer_airplay")
#define DFPlayer_lastImage      DFPlayerImage(@"dfplayer_last")
#define DFPlayer_nextImage      DFPlayerImage(@"dfplayer_next")
#define DFPlayer_singleImage    DFPlayerImage(@"dfplayer_single")
#define DFPlayer_circleImage    DFPlayerImage(@"dfplayer_circle")
#define DFPlayer_shuffleImage   DFPlayerImage(@"dfplayer_shuffle")
#define DFPlayer_ovalImage      DFPlayerImage(@"dfplayer_oval")

typedef void(^DFPlayerLyricsBlock)(NSString *onPlayingLyrics);

@interface DFPlayerControlManager() <DFPlayerLyricsTableviewDelegate>
{
    BOOL _stopUpdate;
    BOOL _isSeek;
}

@property (nonatomic, strong) UIButton          *playBtn;
@property (nonatomic, strong) UIButton          *typeBtn;
@property (nonatomic, strong) UIProgressView    *bufferProgressView;
@property (nonatomic, strong) DFPlayerSlider    *progressSlider;
@property (nonatomic, strong) UILabel           *currentTimeLabel;
@property (nonatomic, strong) UILabel           *totalTimeLabel;
@property (nonatomic, strong) DFPlayerLyricsTableview *lyricsTableView;
@property (nonatomic, copy) DFPlayerLyricsBlock lyricsBlock;

@end

@implementation DFPlayerControlManager

+ (DFPlayerControlManager *)sharedManager{
    static DFPlayerControlManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (UIButton *)button:(CGRect)frame
               image:(UIImage *)image
           superView:(UIView *)superView
               block:(nullable void (^)(void))block
              action:(nullable void(^)(void))action{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = frame;
    [btn setBackgroundImage:image forState:(UIControlStateNormal)];
    btn.handleButtonActionBlock = ^(UIButton * _Nullable sender) {
        if (block) {
            block();
        }
        if (action) {
            action();
        }
    };
    [superView addSubview:btn];
    return btn;
}

- (UILabel *)label:(CGRect)frame
         superView:(UIView *)superView
       observerKey:(NSString *)observerKey{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"00:00";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:DF_FONTSIZE(24)];
    [superView addSubview:label];
    [[DFPlayer sharedPlayer] addObserver:self forKeyPath:observerKey options:NSKeyValueObservingOptionNew context:nil];
    return label;
}

- (void)df_stopUpdate{
    _stopUpdate = YES;
    self.lyricsTableView.stopUpdate = YES;
}

- (void)df_resumeUpdate{
    _stopUpdate = NO;
    self.lyricsTableView.stopUpdate = NO;
}


#pragma mark - 播放暂停按钮
- (UIButton *)df_playPauseBtnWithFrame:(CGRect)frame
                             superView:(UIView *)superView
                                 block:(nullable void (^)(void))block{
    UIImage *img = [DFPlayer sharedPlayer].state == DFPlayerStatePlaying ? DFPlayer_playImage : DFPlayer_pauseImage;
    self.playBtn = [self button:frame image:img superView:superView block:block action:^{
        if ([DFPlayer sharedPlayer].state == DFPlayerStatePlaying) {
            [[DFPlayer sharedPlayer] df_pause];
        }else{
            [[DFPlayer sharedPlayer] df_play];
        }
    }];
    [[DFPlayer sharedPlayer] addObserver:self forKeyPath:DFStateKey options:NSKeyValueObservingOptionNew context:nil];
    return self.playBtn;
}

#pragma mark - 上一首按钮
- (UIButton *)df_lastAudioBtnWithFrame:(CGRect)frame
                             superView:(UIView *)superView
                                 block:(nullable void (^)(void))block{
    return [self button:frame image:DFPlayer_lastImage superView:superView block:block action:^{
        [[DFPlayer sharedPlayer] df_last];
    }];
}

#pragma mark - 下一首按钮
- (UIButton *)df_nextAudioBtnWithFrame:(CGRect)frame
                             superView:(UIView *)superView
                                 block:(nullable void (^)(void))block{
    return [self button:frame image:DFPlayer_nextImage superView:superView block:block action:^{
        [[DFPlayer sharedPlayer] df_next];
    }];
}

#pragma mark - 播放模式设置按钮
- (UIButton *)df_typeControlBtnWithFrame:(CGRect)frame
                               superView:(UIView *)superView
                                   block:(nullable void (^)(void))block{
    
    if ([DFPlayer sharedPlayer].playMode == DFPlayerModeOnlyOnce) {
        return nil;
    }
    UIImage *img = [UIImage new];
    if ([DFPlayer sharedPlayer].playMode == DFPlayerModeSingleCycle) {
        img = DFPlayer_singleImage;
    }else if ([DFPlayer sharedPlayer].playMode == DFPlayerModeOrderCycle){
        img = DFPlayer_circleImage;
    }else{
        img = DFPlayer_shuffleImage;
    }
    UIButton *btn = [self button:frame image:img superView:superView block:block action:nil];
    btn.handleButtonActionBlock = ^(UIButton * _Nullable sender) {
        switch ([DFPlayer sharedPlayer].playMode) {
            case DFPlayerModeSingleCycle:
                [DFPlayer sharedPlayer].playMode = DFPlayerModeOrderCycle;
                [sender setBackgroundImage:DFPlayer_circleImage forState:(UIControlStateNormal)];
                break;
            case DFPlayerModeOrderCycle:
                [DFPlayer sharedPlayer].playMode = DFPlayerModeShuffleCycle;
                [sender setBackgroundImage:DFPlayer_shuffleImage forState:(UIControlStateNormal)];
                break;
            case DFPlayerModeShuffleCycle:
                [DFPlayer sharedPlayer].playMode = DFPlayerModeSingleCycle;
                [sender setBackgroundImage:DFPlayer_singleImage forState:(UIControlStateNormal)];
                break;
            default:
                break;
        }
    };
    return btn;
}

#pragma mark - 音频当前时间
- (UILabel *)df_currentTimeLabelWithFrame:(CGRect)frame
                                superView:(UIView *)superView{
    self.currentTimeLabel = [self label:frame superView:superView observerKey:DFCurrentTimeKey];
    return self.currentTimeLabel;
}

#pragma mark - 音频总时长
- (UILabel *)df_totalTimeLabelWithFrame:(CGRect)frame
                              superView:(UIView *)superView{
    self.totalTimeLabel = [self label:frame superView:superView observerKey:DFTotalTimeKey];
    return self.totalTimeLabel;
}

#pragma mark - 缓冲进度条
- (UIProgressView *)df_bufferProgressViewWithFrame:(CGRect)frame
                                    trackTintColor:(UIColor *)trackTintColor
                                 progressTintColor:(UIColor *)progressTintColor
                                         superView:(UIView *)superView{
    self.bufferProgressView = [[UIProgressView alloc] initWithFrame:frame];
    self.bufferProgressView.trackTintColor = trackTintColor;
    self.bufferProgressView.progressTintColor = progressTintColor;
    [superView addSubview:self.bufferProgressView];
    [[DFPlayer sharedPlayer] addObserver:self forKeyPath:DFBufferProgressKey options:NSKeyValueObservingOptionNew context:nil];
    return self.bufferProgressView;
}

#pragma mark - 播放进度条
- (UISlider *)df_sliderWithFrame:(CGRect)frame
           minimumTrackTintColor:(UIColor *)minimumTrackTintColor
           maximumTrackTintColor:(UIColor *)maximumTrackTintColor
                     trackHeight:(CGFloat)trackHeight
                       thumbSize:(CGSize)thumbSize
                       superView:(UIView *)superView{
    self.progressSlider = [[DFPlayerSlider alloc] initWithFrame:frame];
    self.progressSlider.trackHeight = trackHeight;
    UIImage *img = [DFPlayer_ovalImage df_imageByResizeToSize:thumbSize];
    [self.progressSlider setThumbImage:img forState:UIControlStateNormal];
    self.progressSlider.minimumValue = 0;
    self.progressSlider.maximumValue = 1;
    self.progressSlider.minimumTrackTintColor = minimumTrackTintColor;
    self.progressSlider.maximumTrackTintColor = maximumTrackTintColor;
    [superView addSubview:self.progressSlider];
    
    [[DFPlayer sharedPlayer] addObserver:self forKeyPath:DFProgressKey options:NSKeyValueObservingOptionNew context:nil];
    
    //开始滑动
    [self.progressSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
    //滑动中
    [self.progressSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    //滑动结束
    [self.progressSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    //点击slider
    UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapSliderAction:)];
    [self.progressSlider addGestureRecognizer:sliderTap];
    return self.progressSlider;
}

- (void)progressSliderTouchBegan:(UISlider *)sender{
    _isSeek = YES;
}

- (void)progressSliderValueChanged:(UISlider *)sender{
    CGFloat time = [DFPlayer sharedPlayer].totalTime * self.progressSlider.value;
    [self configTimeLabel:self.currentTimeLabel time:time];
}

- (void)progressSliderTouchEnded:(UISlider *)sender{
    [self seek:self.progressSlider.value];
}

- (void)handleTapSliderAction:(UITapGestureRecognizer *)tap{
    if ([tap.view isKindOfClass:[UISlider class]]) {
        _isSeek = YES;
        UISlider *slider = (UISlider *)tap.view;
        CGPoint point    = [tap locationInView:slider];
        CGFloat value    = point.x / slider.frame.size.width;
        [self seek:value];
    }
}

- (void)seek:(CGFloat)value{
     [[DFPlayer sharedPlayer] df_seekToTime:value completionBlock:^{
         [[NSNotificationCenter defaultCenter] postNotificationName:DFPlayerNotificationSeekEnd object:nil];
         self->_isSeek = NO;
     }];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == [DFPlayer sharedPlayer]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([keyPath isEqualToString:DFStateKey]) {
                if (!self->_isSeek) {
                    UIImage *img = [DFPlayer sharedPlayer].state == (DFPlayerStateBuffering | DFPlayerStatePlaying) ? DFPlayer_pauseImage : DFPlayer_playImage;
                    [self.playBtn setBackgroundImage:img forState:(UIControlStateNormal)];
                }
            }else{
                if (self->_stopUpdate) {
                    return;
                }
                if ([keyPath isEqualToString:DFBufferProgressKey]){
                    [self.bufferProgressView setProgress:[DFPlayer sharedPlayer].bufferProgress];
                }else if ([keyPath isEqualToString:DFProgressKey]){
                    if (!self->_isSeek) {
                        if (self.progressSlider.state != UIControlStateHighlighted) {
                            self.progressSlider.value = [DFPlayer sharedPlayer].progress;
                        }
                    }
                }else if ([keyPath isEqualToString:DFCurrentTimeKey]){
                    if (!self->_isSeek) {
                        [self configTimeLabel:self.currentTimeLabel time:[DFPlayer sharedPlayer].currentTime];
                    }
                }else if ([keyPath isEqualToString:DFTotalTimeKey]){
                    [self configTimeLabel:self.totalTimeLabel time:[DFPlayer sharedPlayer].totalTime];
                }
            }
        });
    }
}

- (void)configTimeLabel:(UILabel *)label time:(CGFloat)time{
    NSInteger seconds = (NSInteger)time % 60;
    NSInteger minutes = ((NSInteger)time / 60) % 60;
    dispatch_async(dispatch_get_main_queue(), ^{
        label.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)minutes,(long)seconds];
    });
}

- (void)dealloc{
    [[DFPlayer sharedPlayer] removeObserver:self forKeyPath:DFStateKey];
    [[DFPlayer sharedPlayer] removeObserver:self forKeyPath:DFBufferProgressKey];
    [[DFPlayer sharedPlayer] removeObserver:self forKeyPath:DFProgressKey];
    [[DFPlayer sharedPlayer] removeObserver:self forKeyPath:DFCurrentTimeKey];
    [[DFPlayer sharedPlayer] removeObserver:self forKeyPath:DFTotalTimeKey];
}

#pragma mark - 歌词tableview

- (UITableView *)df_lyricTableViewWithFrame:(CGRect)frame
                              cellRowHeight:(CGFloat)cellRowHeight
                        cellBackgroundColor:(UIColor *)cellBackgroundColor
          currentLineLrcForegroundTextColor:(nullable UIColor *)currentLineLrcForegroundTextColor
          currentLineLrcBackgroundTextColor:(UIColor *)currentLineLrcBackgroundTextColor
            otherLineLrcBackgroundTextColor:(UIColor *)otherLineLrcBackgroundTextColor
                         currentLineLrcFont:(UIFont *)currentLineLrcFont
                           otherLineLrcFont:(UIFont *)otherLineLrcFont
                                  superView:(UIView *)superView
                                      block:(nullable void (^)(NSString * onPlayingLyrics))block{
    self.lyricsTableView = [[DFPlayerLyricsTableview alloc] init];
    self.lyricsTableView.frame                             = frame;
    self.lyricsTableView.backgroundColor                   = cellBackgroundColor;
    self.lyricsTableView.cellRowHeight                     = cellRowHeight;
    self.lyricsTableView.cellBackgroundColor               = cellBackgroundColor;
    self.lyricsTableView.currentLineLrcForegroundTextColor = currentLineLrcForegroundTextColor;
    self.lyricsTableView.currentLineLrcBackgroundTextColor = currentLineLrcBackgroundTextColor;
    self.lyricsTableView.otherLineLrcBackgroundTextColor   = otherLineLrcBackgroundTextColor;
    self.lyricsTableView.currentLineLrcFont                = currentLineLrcFont;
    self.lyricsTableView.otherLineLrcFont                  = otherLineLrcFont;
    self.lyricsTableView.lrcTableViewSuperview             = superView;
    self.lyricsTableView.lyricsDelegate                    = self;
    [superView addSubview:self.lyricsTableView];
    if (block) { self.lyricsBlock = block; }
    return self.lyricsTableView;
}

- (void)df_lyricsTableview:(DFPlayerLyricsTableview *)lyricsTableview
           onPlayingLyrics:(NSString *)onPlayingLyrics{
    if (self.lyricsBlock) {
        self.lyricsBlock(onPlayingLyrics);
    }
}


@end


