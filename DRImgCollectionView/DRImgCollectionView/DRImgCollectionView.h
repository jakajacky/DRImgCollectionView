//
//  DRImgCollectionView.h
//  DRImgCollectionView
//
//  Created by xqzh on 16/6/28.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PageControlLocCenter, // 底部居中
    PageControlLocRight,   // 底部靠右
    PageControlLocRightSide // 侧边靠右
} PageControlLoc;

@interface DRImgCollectionView : UIView

@property (nonatomic, strong) NSDictionary *attributeList;

/*
 * dotColor 颜色
 * dotSize  大小
 */
- (instancetype)initWithFrame:(CGRect)frame andImgArray:(NSArray *)array dotColor:(UIColor *)dotColor dotSize:(NSInteger)radius;

/*
 * 可以不使用该方法设置以下属性，只在初始化时设置大小和颜色
 * image可以为nil
 * direction将默认使用水平滚动
 * location默认底部居中
 */
- (void)setAttributeListWithDirection:(UICollectionViewScrollDirection)direction
                             Location:(PageControlLoc)location
                             dotImage:(UIImage *)dotImage
                      currentDotImage:(UIImage *)currentDotImage
                      backgroundColor:(UIColor *)backgroundColor;

@end
