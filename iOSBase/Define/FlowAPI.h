//
//  FlowAPI.h
//  Keepcaring
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#ifndef FlowAPI_h
#define FlowAPI_h

/**<转换16进制颜色*/
#define UIColorFromHex(HexValue) ([UIColor colorWithHex:HexValue])

/**<RGB颜色设置*/
#define UI_ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]

/**<本地的文件目录路径*/
#define kLocalFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LocalFileDirectory"]

/**<本地的文件目录*/
#define LocalFileDirectory [Util createFileDirectory:kLocalFilePath]

/**<用户的文件目录*/
#define UserModelPath [LocalFileDirectory stringByAppendingPathComponent:@"userModel.archive"]

/**<设备信息的文件目录*/
#define DeviceDataPath [LocalFileDirectory stringByAppendingPathComponent:@"DeviceData.archive"]

/**<下载的文件目录*/
#define DownloadFilePath [LocalFileDirectory stringByAppendingPathComponent:@"downloadFileDirectory"]

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height

// 主服务器地址
#define SERVER_IP         @""

// 登录
#define API_LOGIN       SERVER_IP@""

#endif /* FlowAPI_h */
