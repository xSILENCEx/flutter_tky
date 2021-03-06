//
//  TKWhiteBroadManager.h
//  TKWhiteBroad
//
//  Created by MAC-MiNi on 2018/4/9.
//  Copyright © 2018年 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TKWhiteBoardManagerDelegate.h"

@class TKWBRoomConfiguration;
@class TKFileModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^loadFinishedBlock) (void);
typedef void(^pageControlMarkBlock)(NSDictionary *);

typedef NSArray* _Nullable (^WebContentTerminateBlock)(void);

@interface TKWhiteBoardManager : NSObject
@property (nonatomic, copy) NSString * serverDocAddrKey;//文档服务器地址
@property (nonatomic, assign, readonly) BOOL isBeginClass;// 是否已上课
@property (nonatomic, assign, readonly) BOOL isShowOnWeb;  // 是否web加载;
@property (nonatomic, assign, readonly) BOOL isSelectMouse;// 画笔工具是否选择了鼠标;

@property (nonatomic, copy) WebContentTerminateBlock _Nullable webContentTerminateBlock;//webview内存过高白屏回调
@property (nonatomic, copy) pageControlMarkBlock pageControlMarkBlock;// 课件备注
@property (nonatomic, copy) NSString *address; // 文档服务器地址
@property (nonatomic, copy) NSDictionary *configration;//配置项

@property (nonatomic, strong) UIColor * whiteBoardBgColor;//白板背景色
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) TKFileModel *fModel;// 当前加载的文档模型

@property (nonatomic, weak)   id<TKWhiteBoardManagerDelegate> wbDelegate;
@property (nonatomic, strong) TKWBRoomConfiguration * roomConfig; //房间配置项
@property (nonatomic, strong) NSMutableDictionary * whiteBoardCustomBgDic;//自动以白板背景数据

@property (nonatomic, strong) NSArray *fileList;

/**
 单例
 */
+ (instancetype)shareInstance;
/**
 销毁白板
 */
+ (void)destroy;

/**
 注册白板 代理和配置
 */
- (void)registerDelegate:(id<TKWhiteBoardManagerDelegate>)delegate configration:(NSDictionary *)config;


//创建白板组件
- (UIView *)createWhiteBoardWithFrame:(CGRect)frame
                    loadComponentName:(NSString *)loadComponentName
                           tk_version:(NSString *)tk_version
                    loadFinishedBlock:(loadFinishedBlock)loadFinishedBlock;



// 显示课件
- (int)showDocumentWithFile:(TKFileModel *)file isPubMsg:(BOOL)isPubMsg;


// 重置白板所有的数据
 
- (void)resetWhiteBoardAllData;

// 刷新白板
- (void)refreshWhiteBoard;

// 刷新 webview scrollview offset (键盘消失 webview 不弹回)
- (void)refreshWBWebViewOffset:(CGPoint) point;

//关闭动态ppt视频播放
- (void)unpublishNetworkMedia:(id _Nullable)data;

//断开连接
- (void)disconnect:(NSString *_Nullable)reason;

/**
 房间失去连接
 
 @param reason 原因
 */
- (void)roomWhiteBoardOnDisconnect:(NSString * _Nullable)reason;

/**
 清空所有数据
 */
- (void)clearAllData;

/**
 重新加载白板  @此方法仅供白板测试使用
 */
- (void)webViewReload;

#pragma mark - 画笔控制
// 选择工具
- (void)brushToolsDidSelect:(TKBrushToolType)BrushToolType;

// 选择图形
- (void)didSelectDrawType:(TKDrawType)type color:(NSString *)hexColor widthProgress:(float)progress;


/**
 课件备注回调

 @param block block
 */
- (void)setPageControlMarkBlock:(pageControlMarkBlock)block;

/**
 课件 上一页
 */
- (void)whiteBoardPrePage;

/**
 课件 下一页
 */
- (void)whiteBoardNextPage;

/**
 课件 跳转页

 @param pageNum 页码
 */
- (void)whiteBoardTurnToPage:(int)pageNum;

/**
 白板 放大
 */
- (void)whiteBoardEnlarge;

/**
 白板 缩小
 */
- (void)whiteBoardNarrow;

/**
 白板 放大重置
 */
- (void)whiteBoardResetEnlarge;

- (void)fetchWhiteBoardThnumbnailCallback:(void(^)(NSString *fileid, NSInteger pageNum, UIImage *image))block;

- (void)recordAudioUploadUrl:(NSString *)url_str;

NS_ASSUME_NONNULL_END
@end
