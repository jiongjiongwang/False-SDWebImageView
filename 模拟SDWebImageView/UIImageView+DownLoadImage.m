//
//  UIImageView+DownLoadImage.m
//  模拟SDWebImageView
//
//  Created by 王炯 on 16/6/13.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "UIImageView+DownLoadImage.h"
#import "DownLoadImgManager.h"

#warning 添加运行时系统的关联对象功能
#import <objc/runtime.h>

//设置关联的key
const char * KEY = "key";


@implementation UIImageView (DownLoadImage)
//分类中不能synthesize
//@synthesize currentIMGAddr = _currentIMGAddr;

#warning 利用运行时系统给currentIcon添加get方法和set方法

//set方法
-(void)setCurrentIcon:(NSString *)currentIcon
{
    /*
     1.对象
     2.关联KEY
     3.关联的值
     4.关联策略-属性关键字(nonatomic,copy)
     */
    objc_setAssociatedObject(self, KEY, currentIcon, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//get方法
-(NSString *)currentIcon
{
    /*
     1.对象
     2.关联KEY
     */
    return objc_getAssociatedObject(self, KEY);
}

-(void)DownLoadImageWithUrlStr:(NSString *)imageUrlString
{
    //如何判断之前是否点击:变量记录之前图片下载地址,再次点击,生成新的下载地址,判断之前的地址与当前modleicon地址石头一致,如果不同->之前一定是点击过的
    if (!([self.currentIcon isEqualToString:imageUrlString]))
    {
        
        //开启取消图片下载服务
        [[DownLoadImgManager shardManager] cancelDownWithImgStr:self.currentIcon];
    }
    
    //更新_currentIcon信息
    self.currentIcon  = imageUrlString;
    
    
    //开启下载图片服务
    [[DownLoadImgManager shardManager] DownloadImgWithImgStr:imageUrlString andBlock:^(UIImage *image) {
        
        self.image = image;
        
    }];
}

@end
