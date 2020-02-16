//
//  LDVideoViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVideoViewController.h"
#import "LDTagView.h"
#import "LDVideoTableViewCell.h"
#import "SDCycleScrollView.h"
#import "LDTagModel.h"
#import "LDVideoModel.h"
#import "LDWebViewViewController.h"
#import "LDTagCell.h"
#import "LDHeadCollectionReusableView.h"
#import "LDVideoListViewController.h"
@interface LDVideoViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger currentIndex;
}
@property (nonatomic,strong)LDTagView * tagView;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSArray * tagArray;

@end

@implementation LDVideoViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.netImages = @[];
    [self configUI];
    [self requestTag];
}

- (void)requestTag {
//    getVideoMark
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"/video/getVideoMark" requestParameters:@{@"id":@2} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.tagArray = [NSArray yy_modelArrayWithClass:[LDTagModel class] json:responseObject[@"data"]];
            [self.collectionView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}

#pragma  mark - SDCyclesScrollview
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}
#pragma  mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.tagArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    LDTagModel *model = self.tagArray[section];
    return model.markList.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LDTagCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"LDTagCell" forIndexPath:indexPath];\
    LDTagModel *model = self.tagArray[indexPath.section];
    LDTagDetailModel *detailModel = model.markList[indexPath.row];
    cell.titleLabel.text = detailModel.markDesc;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LDTagModel *model = self.tagArray[indexPath.section];
    LDTagDetailModel *detailModel = model.markList[indexPath.row];
    LDVideoListViewController *vc = [LDVideoListViewController new];
    vc.tagID =  [NSString stringWithFormat:@"%@",detailModel.tagId];
    vc.title = detailModel.markDesc;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(PtWidth(20), PtWidth(20), PtWidth(20), PtWidth(20));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 30);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    { // header
        reuseIdentifier = @"LDHeadCollectionReusableView";
    }
    LDHeadCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    LDTagModel *model = self.tagArray[indexPath.section];
    headView.titleLabel.text = model.parentItemDesc;
    [headView.headImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"mine_list_daily"]];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        
    }
    return headView;
}

#pragma mark - private method
- (void)configUI {
    [self masLayoutSubviews];
}
#pragma  mark - LayoutSubviews
- (void)masLayoutSubviews {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(0);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}
#pragma mark - get and set

- (LDTagView *)tagView {
    if (!_tagView) {
        _tagView = [[LDTagView alloc]initWithFrame:CGRectMake(0, PtHeight(30), SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _tagView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_1"];
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 10;
    }
    return _cycleScrollView;
}

- (void)setNetImages:(NSArray *)netImages{
    _netImages = netImages;
    self.cycleScrollView.imageURLStringsGroup = netImages;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 12;
        flowLayout.minimumLineSpacing = 12;
        flowLayout.itemSize = CGSizeMake(PtWidth(100), PtHeight(40));
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:@"LDTagCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LDTagCell"];
        //注册分区头标题;
        [_collectionView registerNib:[UINib nibWithNibName:@"LDHeadCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDHeadCollectionReusableView"];
    }
    return _collectionView;
}
@end
