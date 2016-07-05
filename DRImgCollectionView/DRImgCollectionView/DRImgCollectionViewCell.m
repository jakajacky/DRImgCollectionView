//
//  DRImgCollectionViewCell.m
//  DRImgCollectionView
//
//  Created by xqzh on 16/6/28.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "DRImgCollectionViewCell.h"

@interface DRImgCollectionViewCell ()


@end


@implementation DRImgCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgView.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.imgView];
    }
    return self;
}

@end
