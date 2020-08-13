//
//  THSpeechController.m
//  AVSpeechDemo
//
//  Created by 范云飞 on 2020/8/12.
//  Copyright © 2020 范云飞. All rights reserved.
//

#import "THSpeechController.h"
#import <AVFoundation/AVFoundation.h>

@interface THSpeechController ()

@property (nonatomic, strong) AVSpeechSynthesizer * synthesizer;
@property (nonatomic, strong) NSArray * voices;
@property (nonatomic, strong) NSArray * speechStrings;

@end

@implementation THSpeechController
+ (instancetype)speechController {
    return [[self alloc] init];
}

- (id)init {
    self = [super init];
    if (self) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        _voices = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
        _speechStrings = [self buildSpeechStrings];
    }
    return self;
}

- (NSArray *)buildSpeechStrings {
    return @[@"《战争与和平》作者：列夫·尼古拉耶维奇·托尔斯泰。《战争与和平》问世至今，因其场面浩大，人物繁多，被称为“世界上最伟大的小说”之一。    　　《战争与和平》这部卷帙浩繁的巨著以史诗般广阔与雄浑的气势，生动地描写了1805至1820年俄国社会的重大历史事件和各个生活领域：“近千个人物，无数的场景，国家和私人生活的一切可能的领域，历史，战争，人间一切惨剧，各种情欲，人生各个阶段，从婴儿降临人间的啼声到气息奄奄的老人的感情最后迸发，人所能感受到的一切欢乐和痛苦，各种可能的内心思绪，从窃取自己同伴的钱币的小偷的感觉，到英雄主义的最崇高的冲动和领悟透彻的沉思——在这幅画里都应有尽有。”作者对生活的大面积涵盖和整体把握，对个别现象与事物整体、个人命运与周围世界的内在联系的充分揭示，使《战争与和平》这部小说具有极大的思想和艺术容量。《战争与和平》是托尔斯泰创作的第一部卷秩浩繁的长篇小说。 作者把战争与和平，前线与后方、国内与国外、军队与社会、上层与下层连结起来，既全面反映了时代风貌，又为各式各样的典型人物创造了极广阔的典型环境。作者对人物的描写形象既复杂又丰满，常用对比的艺术方法来表述，体裁在俄国文学史上是一种创新，也超越了欧洲长篇小说的传统规范。"];
}

- (void)beginConversation {
    for (NSUInteger i = 0; i < self.speechStrings.count; i++) {
        AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:self.speechStrings[i]];
        utterance.voice = self.voices[0];
        utterance.rate = 0.5f;
        utterance.pitchMultiplier = 0.8f;
        utterance.postUtteranceDelay = 0.1f;
        [self.synthesizer speakUtterance:utterance];
    }
}

@end
