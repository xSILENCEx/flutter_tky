//
//  TKWhiteBroadDelegate.h
//  TKWhiteBroad
//
//  Created by MAC-MiNi on 2018/4/9.
//  Copyright © 2018年 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TKWhiteBoardManagerDelegate <NSObject>

@required

/**
 文件列表回调
 @param fileList 文件列表 是一个NSArray类型的数据
 */
- (void)onWhiteBroadFileList:(NSArray *)fileList;

/**
 返回文档服务器地址
 */
- (void)onWhiteBroadGetServerAddress:(NSString *)serverAddress;

/**
PubMsg消息
 */
- (void)onWhiteBroadPubMsgWithMsgName:(NSString *)msgName msgID:(NSString *)msgID message:(NSDictionary *)message;

/**
 msglist消息

 @param msgList 消息
 */
- (void)onWhiteBoardOnRoomConnectedMsglist:(NSDictionary *)msgList;

/**
 界面更新
 */
- (void)onWhiteBoardViewStateUpdate:(NSDictionary *)message;
- (void)onWhiteBoardShowOnViewRatioUpdate:(CGFloat)ratio;// 原生加载课件的 ratio 更新

- (BOOL)onWhiteBoardOnRoomContainsUserTKVersionBelowNumber_6;

- (void)onWhiteBroadFileZoomChange:(CGFloat)scale;

// onRecordAudio 音频录制
- (void)onWhiteBroadRecordAudio_isStart:(BOOL)isStart;
@end

