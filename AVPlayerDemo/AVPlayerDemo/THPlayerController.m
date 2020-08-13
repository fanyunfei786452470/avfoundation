//
//  THPlayerController.m
//  AVPlayerDemo
//
//  Created by 范云飞 on 2020/8/13.
//  Copyright © 2020 范云飞. All rights reserved.
//

#import "THPlayerController.h"
#import <AVFoundation/AVFoundation.h>

@interface THPlayerController ()

@property (nonatomic, readwrite, assign) BOOL playing;
@property (nonatomic, strong) NSArray * players;

@end

@implementation THPlayerController
- (instancetype)init {
    self = [super init];
    if (self) {
        AVAudioPlayer * guitarPlayer = [self playerForFile:@"guitar"];
        AVAudioPlayer * bassPlayer = [self playerForFile:@"bass"];
        AVAudioPlayer * drumsPlayer = [self playerForFile:@"drums"];
        _players = @[guitarPlayer, bassPlayer, drumsPlayer];
        
        [self registerNotifications];
    }
    return self;
}

- (void)play {
    if (!self.playing) {
        NSTimeInterval delayTime = [self.players[0] deviceCurrentTime] + 0.01;
        for (AVAudioPlayer *player in self.players) {
            [player playAtTime:delayTime];
        }
        self.playing = YES;
    }
}

- (void)stop {
    if (self.playing) {
        for (AVAudioPlayer *player in self.players) {
            [player stop];
            player.currentTime = 0.0f;
        }
        self.playing = NO;
    }
}

- (void)adjustRate:(float)rate {
    for (AVAudioPlayer *player in self.players) {
        player.rate = rate;
    }
}

- (void)adjustPan:(float)pan forPlayerAtIndex:(NSUInteger)index {
    if ([self isValidIndex:index]) {
        AVAudioPlayer *player = self.players[index];
        player.pan = pan;
    }
}

- (void)adjustVolume:(float)volume forPlayerAtIndex:(NSUInteger)index {
    if ([self isValidIndex:index]) {
        AVAudioPlayer *player = self.players[index];
        player.volume = volume;
    }
}

- (BOOL)isValidIndex:(NSUInteger)index {
    return index == 0 || index < self.players.count;
}

- (AVAudioPlayer *)playerForFile:(NSString *)name {
    NSURL * fileURL = [[NSBundle mainBundle] URLForResource:name withExtension:@"caf"];
    NSError * error;
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    if (player) {
        player.numberOfLoops = -1;
        player.enableRate = YES;
        [player prepareToPlay];
    } else {
        NSLog(@"Error creating player:%@",[error localizedDescription]);
    }
    return player;
}

- (void)registerNotifications {
    NSNotificationCenter * notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    [notification addObserver:self selector:@selector(handleRouteChange:) name:AVAudioSessionRouteChangeNotification object:[AVAudioSession sharedInstance]];
}

- (void)handleInterruption:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    AVAudioSessionInterruptionType type = [info[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    if (type == AVAudioSessionInterruptionTypeBegan) {
        // Handle AVAudioSessionInterruptionTypeBegan
        [self stop];
        if (self.delegate && [self.delegate respondsToSelector:@selector(playbackStopped)]) {
            [self.delegate playbackStopped];
        }
    } else {
        // Handle AVAudioSessionInterruptionTypeEnded
        AVAudioSessionInterruptionOptions options = [info[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
        if (options == AVAudioSessionInterruptionOptionShouldResume) {
            [self play];
            if (self.delegate && [self.delegate respondsToSelector:@selector(playbackBegan)]) {
                [self.delegate playbackBegan];
            }
        }
    }
}

- (void)handleRouteChange:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    AVAudioSessionRouteChangeReason reason = [info[AVAudioSessionRouteChangeReasonKey] unsignedIntegerValue];
    if (reason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *previousRoute = info[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *previousOutput = previousRoute.outputs[0];
        NSString *portType = previousOutput.portType;
        if ([portType isEqualToString:AVAudioSessionPortHeadphones]) {
            [self stop];
            [self.delegate playbackStopped];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
