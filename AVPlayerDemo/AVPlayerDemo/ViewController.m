//
//  ViewController.m
//  AVPlayerDemo
//
//  Created by 范云飞 on 2020/8/12.
//  Copyright © 2020 范云飞. All rights reserved.
//

#import "ViewController.h"
#import "THPlayerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, 500, 80, 30)];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(speechClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)speechClick:(UIButton *)sender {

}

@end
