#import "FlutterTkyPlugin.h"

#import <TKUISDK/TKUISDK.h>
#import <TKRoomSDK/TKRoomSDK.h>

@implementation FlutterTkyPlugin

NSString* funcName;
FlutterMethodChannel* ch;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_tky"
            binaryMessenger:[registrar messenger]];
  FlutterTkyPlugin* instance = [[FlutterTkyPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"joinClassRoom" isEqualToString:call.method]) {
      result([@"iOS " stringByAppendingString: [self joinRoom: call.arguments]]);
  } else if ([@"tkyViewBack" isEqualToString:call.method]){
      result([@"iOS " stringByAppendingString: [self joinTkyViewBack: call.arguments]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}


//进入拓课云教室
- (NSString*)joinRoom:(NSDictionary*)paramDic {
    NSLog(@"%@", paramDic);
    funcName = @"joinTkyRoom";
    dispatch_async(dispatch_get_main_queue(), ^{
      UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
      [[TKEduClassManager shareInstance] joinRoomWithParamDic:paramDic ViewController:vc Delegate:self isFromWeb:NO];
    });
    
    return @"joinRoom Success";
}

//进入拓课云教室回放
- (NSString*)joinTkyViewBack:(NSString*)p {
    NSLog(@"%@", p);
    funcName = @"tkyViewBack";
    dispatch_async(dispatch_get_main_queue(), ^{
      UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
      [[TKEduClassManager shareInstance] joinRoomWithPlaybackPath:p ViewController:vc];
    });
    
    return @"joinTkyViewBack Success";
}

//退出拓课云教室
- (void)exitRoom{
    [ch invokeMethod:@"exitRoom" arguments:funcName];
}

/**
 进入房间失败
 
 @param result 错误码 详情看 TKRoomSDK -> TKRoomDefines ->TKRoomErrorCode 结构体
 
 @param desc 失败的原因描述
 */
- (void)onEnterRoomFailed:(int)result Description:(NSString*)desc
{
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d", result], @"i", desc, @"s", nil];
    [ch invokeMethod:@"onEnterRoomFailed" arguments: data];
}

/**
 被踢回调

 @param reason 1:被老师踢出 400：重复登录
 */
- (void)onKitout:(int)reason
{
    [ch invokeMethod:@"onKitout" arguments: [NSString stringWithFormat:@"%d", reason]];
}

/**
 进入课堂成功后的回调
 */
- (void)joinRoomComplete
{
    [ch invokeMethod:@"joinRoomComplete" arguments: nil];
}

/**
 离开课堂成功后的回调
 */
- (void)leftRoomComplete
{
    [self exitRoom];
}

/**
 课堂开始的回调
 */
- (void)onClassBegin
{
    [ch invokeMethod:@"onClassBegin" arguments: nil];
}

/**
 课堂结束的回调
 */
- (void)onClassDismiss
{
    [ch invokeMethod:@"onClassDismiss" arguments: nil];
}

/**
 摄像头打开失败回调
 */
- (void)onCameraDidOpenError
{
    [ch invokeMethod:@"onCameraDidOpenError" arguments: nil];
}

@end
