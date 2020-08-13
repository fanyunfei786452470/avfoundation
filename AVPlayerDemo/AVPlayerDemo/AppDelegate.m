//
//  AppDelegate.m
//  AVPlayerDemo
//
//  Created by 范云飞 on 2020/8/12.
//  Copyright © 2020 范云飞. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    #if DEBUG
        [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    #endif
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController * vc = [[ViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [self configAudioSession];
    
    return YES;
}

- (void)configAudioSession {
    AVAudioSession * session = [AVAudioSession sharedInstance];
    NSError * error;
    if (![session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
        NSLog(@"Category Error: %@", [error localizedDescription]);
    }
    if (![session setActive:YES error:&error]) {
        NSLog(@"Activation Error: %@", [error localizedDescription]);
    }
}

@end
