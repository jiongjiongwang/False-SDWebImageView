//
//  DownLoadImgManager.m
//  模拟SDWebImageView
//
//  Created by 王炯 on 16/6/13.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "DownLoadImgManager.h"
#import "DownLoadImage.h"
#import "NSString+Path.h"


@interface DownLoadImgManager()

//操作队列
@property (nonatomic,strong)NSOperationQueue *queue;


//定义一个操作缓存字典
@property (nonatomic,strong)NSMutableDictionary *operationDict;

//定义一个图片缓存字典
@property (nonatomic,strong)NSMutableDictionary *imageDict;


@end


@implementation DownLoadImgManager

//创建一个静态实例对象
static id instance;

+(instancetype)shardManager
{
    //利用dispatch_once实现单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //无论是单线程还是多线程环境下，只会执行一次
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

//懒加载队列
-(NSOperationQueue *)queue
{
    if (_queue == nil)
    {
        _queue = [[NSOperationQueue alloc] init];
    }
    
    return _queue;
}


//懒加载操作缓存字典
-(NSMutableDictionary *)operationDict
{
    if (!_operationDict)
    {
        _operationDict = [NSMutableDictionary dictionary];
    }
    
    return _operationDict;
}

//懒加载图片缓存字典
-(NSMutableDictionary *)imageDict
{
    if (!_imageDict)
    {
        _imageDict = [NSMutableDictionary dictionary];
    }
    
    return _imageDict;
}

//提供下载服务
-(void)DownloadImgWithImgStr:(NSString *)imgStr andBlock:(FinishBlcok)finishBlcok
{
    
    //从内存或沙盒中获取当前imgStr对应的图片是否存在
    UIImage *cacheImage = self.imageDict[imgStr];
    
    //内存缓存中时候存在
    if (cacheImage)
    {
        NSLog(@"从内存中获取图片%@",imgStr);
        
        finishBlcok(cacheImage);
        
        return;
    }
    //沙盒中是否存在
    else
    {
        UIImage *sandBoxImage = [UIImage imageWithContentsOfFile:[imgStr appendCachePath]];
        if (sandBoxImage)
        {
            NSLog(@"从沙盒中获取图片%@",imgStr);
            
            finishBlcok(sandBoxImage);
            
            //性能优化
            [self.imageDict setObject:sandBoxImage forKey:imgStr];
            return;
        }
    }
    
    
    
    //(3)根据数据信息，把数据信息填入到操作中，生成新的操作
    DownLoadImage *downLoadImg = [DownLoadImage DownLoadImageWith:imgStr andBlock:^(UIImage *image) {
        
        finishBlcok(image);
        
        //将操作从缓存字典中删除掉
        [self.operationDict removeObjectForKey:imgStr];
        
        //将图片存放到缓存字典中
        [self.imageDict setObject:image forKey:imgStr];
        
    }];
    
    
    //(4)将操作加入到队列中
    [self.queue addOperation:downLoadImg];
    
    //将操作加入到操作缓存中
    [self.operationDict setObject:downLoadImg forKey:imgStr];
    
    
}

//提供取消下载服务
-(void)cancelDownWithImgStr:(NSString *)imgStr
{
    //开启取消图片下载服务
    //取消之前的操作
    //(1)根据_currentIcon信息从操作缓存中取出之前的操作
    
    
    DownLoadImage *oldOperation = self.operationDict[imgStr];
    
    //如果存在
    if (oldOperation)
    {
        //取消之前旧的操作
        oldOperation.cancelHasDone = YES;
    }
}


@end
