//
//  DownLoadImage.h
//  01-自定义NSOperation类
//
//  Created by 王炯 on 16/6/11.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^FinishBlcok)(UIImage *);


#warning 自定义NSOperation的子类，本操作只去下载图片
@interface DownLoadImage : NSOperation

@property (nonatomic,copy)NSString *imageStr;

@property (nonatomic,copy)FinishBlcok finishBlcok;


//定义一个类方法，用于根据外界传递的数据来实例化响应的实例
+(instancetype)DownLoadImageWith:(NSString *)imageStr andBlock:(FinishBlcok)finishBlcok;



@end
