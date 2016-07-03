//
//  NSTimer+operation.m
//  DRImgCollectionView
//
//  Created by xqzh on 16/6/29.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "NSTimer+operation.h"

@implementation NSTimer (operation)

- (void)pauseTimer {
    if (!self.valid) {
        return;
    }
    self.fireDate = [NSDate distantFuture];
}

- (void)resumeTimer {
    if (!self.valid) {
        return;
    }
    self.fireDate = [NSDate date];
}

@end
