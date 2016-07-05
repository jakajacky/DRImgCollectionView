//
//  DRImgCollectionView.m
//  DRImgCollectionView
//
//  Created by xqzh on 16/6/28.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "DRImgCollectionView.h"
#import "DRImgCollectionViewCell.h"
#import "NSTimer+operation.h"
#import "TAPageControl.h"

#define kWidth  _imgViews.frame.size.width
#define kHeight _imgViews.frame.size.height
#define kMiddleIndex ((_imgArray.count) * (100))

@interface DRImgCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSTimer *_timer;
    UICollectionViewFlowLayout *_layout;
    
    // 可设置 分页指示器属性
    PageControlLoc _pageControlLocation;     // 分页指示器位置，默认底部居中
    CGSize         _dotSize;                 // 分页指示器大小
    UIColor        *_dotColor;               // 当前point的填充颜色，默认灰色
    UIImage        *_dotImage;               // point的图片，默认无
    UIImage        *_currentDotImage;        // 当前point的图片，默认无
    UIColor        *_backgroundColor;        // 背景颜色，默认透明
    
    // 可设置 collectionView属性
    UICollectionViewScrollDirection _direction; // 滚动方向
    

}

@property (nonatomic, strong) NSMutableArray   *imgArray;// 存放图片数组
@property (nonatomic, strong) UICollectionView *imgViews;// 显示图片视图
@property (nonatomic, strong) TAPageControl    *pageView;// 指示器

@end

@implementation DRImgCollectionView

- (instancetype)initWithFrame:(CGRect)frame andImgArray:(NSArray *)array dotColor:(UIColor *)dotColor dotSize:(NSInteger)radius {
    self = [super initWithFrame:frame];
    if (self) {
        _imgArray = [NSMutableArray arrayWithArray:array];
        
        // normal attributes
        _dotColor = dotColor;
        _dotSize  = CGSizeMake(radius, radius);
        
        // layout
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 0;
        _layout.minimumLineSpacing = 0;
        _layout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
        _layout.scrollDirection = _direction;
        
        // collectionView
        _imgViews = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_layout];
        _imgViews.pagingEnabled = YES;
        _imgViews.delegate = self;
        _imgViews.dataSource = self;
        [self addSubview:_imgViews];

        // 注册
        [_imgViews registerClass:[DRImgCollectionViewCell class] forCellWithReuseIdentifier:@"img"];
        
        // 初始位置在中间
        [_imgViews scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:kMiddleIndex inSection:0]
                          atScrollPosition:UICollectionViewScrollPositionNone
                                  animated:false];
        
        // 分页指示器
        [self initPageControl];

        // timer
        _timer = [NSTimer scheduledTimerWithTimeInterval:2
                                                  target:self
                                                selector:@selector(run)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    return self;
}


- (void)initPageControl {
    
    CGRect frame;
    switch (_pageControlLocation) {
        case PageControlLocCenter:
        {
            frame = CGRectMake(0, kHeight - _dotSize.height - 5, kWidth, _dotSize.height);
            break;
        }
        case PageControlLocRight:
        {
            CGFloat rightWidth =
            (_imgArray.count + 1) * 10 + (_imgArray.count) * _dotSize.width;
            
            frame = CGRectMake(kWidth - rightWidth,  kHeight - _dotSize.height - 5, rightWidth, _dotSize.height);
            break;
        }
        case PageControlLocRightSide:
        {
            CGFloat rightWidth =
            (_imgArray.count + 1) * 10 + (_imgArray.count) * _dotSize.width;
            frame = CGRectMake(0, 0, rightWidth, _dotSize.height);
            break;
        }
        default:
            break;
    }
    if (!_pageView) {
        _pageView = [[TAPageControl alloc] initWithFrame:frame];
    }
    else {
        _pageView.frame = frame;
        
    }
    _pageView.numberOfPages = _imgArray.count;
    _pageView.backgroundColor = _backgroundColor? _backgroundColor : [UIColor clearColor];
    _pageView.dotColor = _dotColor;
    _pageView.dotSize  = _dotSize;

    if (_dotImage) {
        _pageView.dotImage = _dotImage;
    }
    if (_currentDotImage) {
        _pageView.currentDotImage = _currentDotImage;
    }
    
    if (_pageControlLocation == PageControlLocRightSide) {
        _pageView.center = CGPointMake(kWidth - _dotSize.height, kHeight / 2);
        CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI/2);
        _pageView.transform = trans;

    }
    
    [self addSubview: _pageView];
}

#pragma mark -
#pragma mark 属性
- (void)setAttributeListWithDirection:(UICollectionViewScrollDirection)direction
                             Location:(PageControlLoc)location
                             dotImage:(UIImage *)dotImage
                      currentDotImage:(UIImage *)currentDotImage
                      backgroundColor:(UIColor *)backgroundColor {
    _direction              = direction;
    _pageControlLocation    = location;
    _dotImage               = dotImage ;
    _currentDotImage        = currentDotImage;
    _backgroundColor        = backgroundColor;
    
    // 更新pageControl
    [self initPageControl];
    
    // 更新collectionView滚动方式
    _layout.scrollDirection = _direction;
}

#pragma mark -
#pragma mark datasourse & dalegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imgArray.count * 200 + 1;  // +1，表示最后一张是 是image0
}

- (DRImgCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DRImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"img" forIndexPath:indexPath];
    cell.imgView.image = nil;
//    NSLog(@"+++%@", cell);
    cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%lu", indexPath.item % _imgArray.count]]; // 循环取图，最后一张是 image0
    
    return cell;
    
}


#pragma mark -
#pragma mark scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 当滚动停止时，如果此时滚动到首页，则将collectionView重置为中间位置
    DRImgCollectionViewCell *cell = _imgViews.visibleCells[0];
    NSIndexPath *index = [_imgViews indexPathForCell:cell];
    
    NSInteger currentPage = index.item % _imgArray.count;
    if (currentPage == 0) {
        [_imgViews scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:kMiddleIndex inSection:0]
                          atScrollPosition:UICollectionViewScrollPositionNone
                                  animated:false];
    }
    
    // 如果巧了，滚动停止时，没有一次位于首页，那么到最后一组的时候，将collectionView重置为中间位置
    if (index.item == _imgArray.count * 200 - _imgArray.count) {
        [_imgViews scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:kMiddleIndex inSection:0]
                          atScrollPosition:UICollectionViewScrollPositionNone
                                  animated:false];
    }
    
    // pageController
    _pageView.currentPage = currentPage;
    
    // 拖拽结束，collectionView停止下来2秒后_timer继续
    [self performSelector:@selector(delay) withObject:nil afterDelay:2];
    NSLog(@"--------");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 手指滑动时，暂停时间器
    [_timer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)delay {
   [_timer resumeTimer];
}

#pragma mark -
#pragma mark 时间触发器
- (void)run {
    DRImgCollectionViewCell *cell = _imgViews.visibleCells[0];
    NSIndexPath *index = [_imgViews indexPathForCell:cell];
//    NSLog(@"%ld", index.item);
    NSInteger currentPage = (index.item + 1) % _imgArray.count;
    if (index.item + 1 <= _imgArray.count * 200) { // 非collectionView的边界

        [_imgViews scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index.item + 1 inSection:0]
                          atScrollPosition:UICollectionViewScrollPositionNone
                                  animated:true];
    }
    else { // collectionView到达尽头的最后一张，也就是image0，切换回 中间位置，继续显示image0，这样有个问题就是最后一张得image0显示的时间变为4s
        [_imgViews scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:kMiddleIndex inSection:0]
                          atScrollPosition:UICollectionViewScrollPositionNone
                                  animated:false];
        
    }
    
    // pageController
    _pageView.currentPage = currentPage;
    
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout


- (void)dealloc {
    [_timer invalidate];
}

@end
