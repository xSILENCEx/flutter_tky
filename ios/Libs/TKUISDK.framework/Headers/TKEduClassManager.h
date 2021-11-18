//
//  TKEduClassManager.h
//  TKUISDK
//
//  Created by talkcloud on 2019/9/24.
//  Copyright © 2019 talkcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKEduRoomDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKEduClassManager : NSObject

/**
 checkRoom成功后 房间属性
 */
@property (nonatomic, strong)NSDictionary *roomJson;

// 外部连接打开
@property (nonatomic, assign) BOOL  isUrlOpen;


+ (instancetype)shareInstance;

/**
 进入房间的函数
 @param paramDic *号为必填
 	serial（* 课堂号）、
 	nickname（* 用户昵称）、
 	role(* 用户角色 老师:"0", 学生:"2", 巡课:"4")、
 	可选:password(密码)、host（服务器地址）、port（服务器端口号）、userid(用户ID，可选)、server(主机, 可选)
 @param controller 视图控制器， 通常与下边delegate相同
 @param delegate 遵循TKEduRoomDelegate代理
 @param isFromWeb 是否是从网址链接进入进入(传NO)
 @return 是否成功 0成功
 */
- (int)joinRoomWithParamDic:(NSDictionary*)paramDic
             ViewController:(UIViewController*)controller
                   Delegate:(id<TKEduRoomDelegate>)delegate
                  isFromWeb:(BOOL)isFromWeb;

/**
 进入回放房间的函数
 
 @param paramDic *号为必填
 	serial（* 课堂号）、
 	path（* 回放路径)、
 	recordtitle(*)、
 	可选:host（服务器地址）、port（服务器端口号)、
 @param controller 视图控制器，通常与下边delegate相同
 @param delegate 遵循TKEduRoomDelegate代理，供给用户进行处理
 @param isFromWeb 是否是从网址链接进入进入
 @return 是否成功 0成功  
 */
- (int)joinPlaybackRoomWithParamDic:(NSDictionary *)paramDic
                     ViewController:(UIViewController*)controller
                           Delegate:(id<TKEduRoomDelegate>)delegate
                          isFromWeb:(BOOL)isFromWeb;

/// 从网页链接进入房间(直播\回放)
/// @param url 网页url
- (void)joinRoomWithUrl:(NSString*)url;


/// 进入MP4回放页面
/// @param path MP4回放地址
/// @param controller 代理
- (void)joinRoomWithPlaybackPath:(NSString*)path ViewController:(UIViewController*)controller;


/// 进入MP4回放页面
/// @param path MP4回放地址
/// @param controller 代理
/// @param skipTime 时间点
/// @param breakurl breakurl
- (void)joinRoomWithPlaybackPath:(NSString*)path ViewController:(UIViewController*)controller skipTime:(NSString *)skipTime breakurl:(NSString *)breakurl;


/// 播放视频
/// @param vc 控制器用于弹出播放页面
/// @param path 视频路径
/// @param style 播放器主题  0:默认主题；1：暗色主题； 2：黑色主题
-(void)playVideo:(UIViewController *)vc path:(NSString *)path style:(NSInteger)style;


/// 离开房间
- (void)leaveRoom;

/// AppDelegate  applicationDidBecomeActive 请调用此方法
- (void)applicationDidBecomeActive;



/// 是否显示课程结束后的web页面, 默认根据后台配置的地址 是否显示.
/// @param isShow 是否显示
- (void)showEndClassWebPage:(BOOL)isShow;


/// 课程结束后的web页面, 默认显示后台配置地址.
/// @param url 地址, 默认拼接 教室号和教室名称
- (void)endClassUrl:(NSString *)url;

@end


NS_ASSUME_NONNULL_END
