# DRImgCollectionView
无限循环轮播---UICollectionView实现方式
自由度很高的自定义滚动方向、分页指示器位置、样式

####导入工程：
方式1、
使用cocoapods
      
      pod 'DRImgCollectionView', '~> 0.0.2'
      
在自己的项目中 
       
       #import "DRImgCollectionView.h"
       
方式2、
下载工程，将最底层的DRImgCollectionView文件夹拖入工程

在自己的项目中 
       
       #import "DRImgCollectionView.h"
       
####使用方法：

    DRImgCollectionView *imgViews = [[DRImgCollectionView alloc] initWithFrame:frame                    // 设置frame
                                                                   andImgArray:imgArray                 // 图片数据源数组 以image0、image1命名
                                                                      dotColor:[UIColor yellowColor]    // 分页指示器 点的颜色
                                                                      dotSize:10];                      // 分页指示器 点的大小
    [imgViews setAttributeListWithDirection:UICollectionViewScrollDirectionHorizontal                   // 轮播图滚动方向
                                   Location:PageControlLocRight                                         // 分页指示器位置
                                   dotImage:nil                                                         // 分页指示器 自定义未选中指示图片
                            currentDotImage:nil                                                         // 分页指示器 自定义选中的指示图片
                            backgroundColor:[UIColor lightTextColor]];                                  // 分页指示器 背景颜色
