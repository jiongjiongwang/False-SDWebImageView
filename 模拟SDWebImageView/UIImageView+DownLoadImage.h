//
//  UIImageView+DownLoadImage.h
//  模拟SDWebImageView
//
//  Created by 王炯 on 16/6/13.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DownLoadImage)

#warning 给UIImageView添加下载图片的功能
-(void)DownLoadImageWithUrlStr:(NSString *)imageUrlString;


#warning 分类中能够定义属性,但是没有自动生成getter&setter方法,对应的成员变量也不生成

@property(nonatomic,copy) NSString *currentIcon;

@end
