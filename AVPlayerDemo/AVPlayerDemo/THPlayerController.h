//
//  THPlayerController.h
//  AVPlayerDemo
//
//  Created by 范云飞 on 2020/8/13.
//  Copyright © 2020 范云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THPlayerControllerDelegate <NSObject>
- (void)playbackStopped;
- (void)playbackBegan;

@end

NS_ASSUME_NONNULL_BEGIN

@interface THPlayerController : NSObject

@property (nonatomic, weak) id <THPlayerControllerDelegate>delegate;
@property (nonatomic, readonly,getter=isPlaying) BOOL playing;

- (void)play;
- (void)stop;
- (void)adjustRate:(float)rate;

- (void)adjustPan:(float)pan;
- (void)adjustVolume:(float)volume;

@end

NS_ASSUME_NONNULL_END
