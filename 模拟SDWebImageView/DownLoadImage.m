//
//  DownLoadImage.m
//  01-自定义NSOperation类
//
//  Created by 王炯 on 16/6/11.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "DownLoadImage.h"

@implementation DownLoadImage


+(instancetype)DownLoadImageWith:(NSString *)imageStr andBlock:(FinishBlcok)finishBlcok
{
    DownLoadImage *downloadImage = [[DownLoadImage alloc] init];
    
    downloadImage.imageStr  = imageStr;
    
    downloadImage.finishBlcok = finishBlcok;
    
    return downloadImage;
}


#warning 在此方法内定义你要做的事，且此方法会自动添加自动释放池，当把操作添加到队列时，会自动调用此方法
-(void)main
{
    
    //网络延时
    [NSThread sleepForTimeInterval:1];

    
   //(1)NSURL
    NSURL *url = [NSURL URLWithString:self.imageStr];
    
    //(2)NSData
    NSData *data = [NSData dataWithContentsOfURL:url];
    
#warning 因为[NSData dataWithContentsOfURL:url]是一个耗时任务，故在此任务完成之后开始拦截操作
    if (self.cancelHasDone)
    {
        NSLog(@"取消下载%@",self.imageStr);
        
        return;
    }
    
    
    //(3)UIImage
    UIImage *image = [UIImage imageWithData:data];
    
    //更新image的操作放在主线程去做
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        //使用block把图片传递给VC中的imageView
        if (_finishBlcok)
        {
            _finishBlcok(image);
        }
        
    }];
}


@end
