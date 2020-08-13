//
//  THPlayerController.h
//  AVPlayerDemo
//
//  Created by 范云飞 on 2020/8/13.
//  Copyright © 2020 范云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THPlayerController : NSObject

@property (nonatomic, readonly,getter=isPlaying) BOOL playing;

- (void)play;
- (void)stop;
- (void)adjustRate:(float)rate;

- (void)adjustPan:(float)pan forPlayerAtIndex:(NSUInteger)index;
- (void)adjustVolume:(float)volume forPlayerAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
