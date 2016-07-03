//
//  ViewController.m
//  DRImgCollectionView
//
//  Created by xqzh on 16/6/28.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "ViewController.h"

#import "DRImgCollectionView.h"


@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"image%d", i]];
        [arr addObject:img];
    }
    
    DRImgCollectionView *im = [[DRImgCollectionView alloc] initWithFrame:
                               CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)
                                                             andImgArray:arr
                                                                dotColor:[UIColor yellowColor]
                                                                 dotSize:15];
    [im setAttributeListWithDirection:UICollectionViewScrollDirectionHorizontal
                             Location:PageControlLocRight
                             dotImage:nil
                      currentDotImage:nil
                      backgroundColor:[UIColor lightTextColor]];
    
    [self.view addSubview:im];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
