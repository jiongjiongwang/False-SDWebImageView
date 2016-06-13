//
//  DownLoadImgManager.h
//  模拟SDWebImageView
//
//  Created by 王炯 on 16/6/13.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownLoadImage.h"


#warning 封装一个管理类，用于提供图片的下载和取消下载的服务，采用单例模式
@interface DownLoadImgManager : NSObject

//实现单例的类方法
+(instancetype)shardManager;


//提供下载图片的服务
-(void)DownloadImgWithImgStr:(NSString *)imgStr andBlock:(FinishBlcok)finishBlcok;


//提供取消下载图片的服务
-(void)cancelDownWithImgStr:(NSString *)imgStr;


@end
