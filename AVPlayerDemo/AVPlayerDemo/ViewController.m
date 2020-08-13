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
@property (nonatomic, strong) THPlayerController * player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * play = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, 200, 80, 30)];
    play.backgroundColor = [UIColor blackColor];
    [play setTitle:@"播放" forState:UIControlStateNormal];
    [play addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:play];
    
    UIButton * stop = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, 500, 80, 30)];
    stop.backgroundColor = [UIColor blackColor];
    [stop setTitle:@"停止" forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stopClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];
}

- (void)playClick:(UIButton *)sender {
    [self.player play];
}

- (void)stopClick:(UIButton *)sender {
    [self.player stop];
}

- (THPlayerController *)player {
    if (!_player) {
        _player = [[THPlayerController alloc] init];
    }
    return _player;
}

@end
