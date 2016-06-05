//
//  PanoramaPicViewController.m
//  MyImageApp
//
//  Created by Mark on 16/6/4.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "PanoramaPicViewController.h"

@interface PanoramaPicViewController ()

@end

@implementation PanoramaPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //PanoramaViewController * parent = self.presentingViewController;
    UIImage* stitchedimage=[CVWrapper processWithArray:_selImages];
    UIImageView *panoPic = [[UIImageView alloc] initWithImage:stitchedimage];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView addSubview:panoPic];
    //scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = panoPic.bounds.size;
    scrollView.maximumZoomScale = 4.0;
    scrollView.minimumZoomScale = 0.5;
    scrollView.contentOffset = CGPointMake(-(scrollView.bounds.size.width-panoPic.bounds.size.width)/2, -(scrollView.bounds.size.height-panoPic.bounds.size.height)/2);
    NSLog (@"scrollview contentSize %@",NSStringFromCGSize(scrollView.contentSize));
    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view.
    
}

- (void)stitch
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
