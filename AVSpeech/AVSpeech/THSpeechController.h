//
//  THSpeechController.h
//  AVSpeechDemo
//
//  Created by 范云飞 on 2020/8/12.
//  Copyright © 2020 范云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THSpeechController : NSObject

+ (instancetype)speechController;
- (void)beginConversation;

@end

NS_ASSUME_NONNULL_END
