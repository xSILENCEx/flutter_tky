package com.liugl.flutter_tky;

import android.app.Activity;

import com.alibaba.fastjson.JSON;
import com.classroomsdk.utils.TKLog;
import com.eduhdsdk.interfaces.JoinmeetingCallBack;
import com.eduhdsdk.interfaces.MeetingNotify;
import com.eduhdsdk.room.RoomClient;
import com.eduhdsdk.room.RoomSession;
import com.eduhdsdk.tools.CrashHandler;
import com.eduhdsdk.tools.FunctionSetManage;
import com.eduhdsdk.tools.PermissionTest;
import com.eduhdsdk.tools.ScreenScale;
import com.eduhdsdk.tools.Tools;
import com.llew.huawei.verifier.LoadedApkHuaWei;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.MethodChannel;

//拓课云相关封装
public class FlutterTky implements MeetingNotify, JoinmeetingCallBack {
    //构造
    FlutterTky(MethodChannel channel) {
        this.methodChannel = channel;
    }

    ///方法通道
    private MethodChannel methodChannel;

    //调用插件的方法名
    private String funcName = "";

    ///是否初始化
    private boolean isInited = false;

    //基础初始化方法
    public int setConfig(String p) {
        @SuppressWarnings("unchecked")
        Map<String, Object> data = JSON.parseObject(p, Map.class);

        if (data.containsKey("appName")) {
            //设置教室内通知样式的app名称
            FunctionSetManage.getInstance().setAppName(Integer.parseInt(Objects.requireNonNull(data.get("appName")).toString()));
        }

        if (data.containsKey("logo")) {
            //设置教室内通知样式logo
            FunctionSetManage.getInstance().setAppLogo(Integer.parseInt(Objects.requireNonNull(data.get("logo")).toString()));
        }

        if (data.containsKey("crashTag")) {
            FunctionSetManage.getInstance().setCarshEnterprise(Objects.requireNonNull(data.get("crashTag")).toString());
        } else {
            FunctionSetManage.getInstance().setCarshEnterprise("flutter_tky_sdk");
        }

        return 0;
    }

    //初始化sdk相关
    private void initSDK(Activity activity) {
        if (isInited) return;
        isInited = true;

        TKLog.enableLog(false);
        ScreenScale.init(activity.getApplication());

        //解决通过反射解决在HuaWei手机出现Register too many Broadcast Receivers的crash
        if (!Tools.phoneIsSony(activity)) {
            LoadedApkHuaWei.hookHuaWeiVerifier(activity.getApplication());
        }

        RoomClient.getInstance().regiestInterface(this, this);

        //设置进入教室时是否跳过设备检测页面(选择添加)
        FunctionSetManage.getInstance().setIsSkipDeviceTesting(activity, false);
        //设置关闭功能引导(选择添加)
        FunctionSetManage.getInstance().setIsGuide(activity, true);
        //日志异常捕获-拓课云
        new CrashHandler(activity);
    }

    ///进入拓课云教室
    public int enterRoomTky(Activity activity, String p) {
        funcName = "joinTkyRoom";

        initSDK(activity);

        System.out.println("拓课云进入教室接收参数============" + p);
        //权限检查
        PermissionTest.requestPermission(activity, 4);

        @SuppressWarnings("unchecked")
        Map<String, Object> data = JSON.parseObject(p, Map.class);

        RoomClient.getInstance().joinRoom(activity, data);

        return 0;
    }

    ///拓课云回放
    public int tkyViewBack(Activity activity, String p) {
        funcName = "tkyViewBack";
        initSDK(activity);
        System.out.println("拓课云进入回放接收参数============" + p);
        RoomClient.getInstance().joinPlayMp4Back(activity, p);
        return 0;
    }

    ///退出教室
    public void exitRoom() {
        if (methodChannel != null) {
            methodChannel.invokeMethod("exitTkyRoom", funcName);
            clear();
        }
    }

    ///清理插件
    public void clear() {
        RoomClient.getInstance().resetInstance();
        RoomSession.getInstance().resetInstance();
        methodChannel = null;
    }

    @Override
    public void onLeftRoomComplete() {
        System.out.println("退出拓课云教室============");
        this.exitRoom();
    }

    @Override
    public void callBack(int i) {
        if (methodChannel != null) {
            methodChannel.invokeMethod("callBack", i);
        }
    }

    @Override
    public void onKickOut(int i, String s) {
        if (methodChannel != null) {
            Map<String, Object> data = new HashMap<>();
            data.put("i", i);
            data.put("s", s);
            methodChannel.invokeMethod("onKickOut", data);
        }
    }

    @Override
    public void onWarning(int i) {
        if (methodChannel != null) {
            methodChannel.invokeMethod("onWarning", i);
        }
    }

    @Override
    public void onClassBegin() {
        if (methodChannel != null) {
            methodChannel.invokeMethod("onClassBegin", "");
        }
    }

    @Override
    public void onClassDismiss() {
        if (methodChannel != null) {
            methodChannel.invokeMethod("onClassDismiss", "");
        }
    }


    @Override
    public void onEnterRoomFailed(int i, String s) {
        if (methodChannel != null) {
            Map<String, Object> data = new HashMap<>();
            data.put("i", i);
            data.put("s", s);
            methodChannel.invokeMethod("onEnterRoomFailed", data);
        }
    }

    @Override
    public void joinRoomComplete() {
        if (methodChannel != null) {
            methodChannel.invokeMethod("joinRoomComplete", "");
        }
    }

    @Override
    public void onCameraDidOpenError() {
        if (methodChannel != null) {
            methodChannel.invokeMethod("onCameraDidOpenError", "");
        }
    }

    @Override
    public void onOpenEyeProtection(boolean isOpen) {
        if (methodChannel != null) {
            methodChannel.invokeMethod("onOpenEyeProtection", isOpen);
        }
    }
}
