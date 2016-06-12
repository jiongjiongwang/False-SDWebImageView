//
//  ViewController.m
//  模拟SDWebImageView
//
//  Created by 王炯 on 16/6/12.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"
#import "DownLoadImage.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@property (nonatomic,strong)NSArray<AppModel *> *dataArray;

//操作队列
@property (nonatomic,strong)NSOperationQueue *queue;

//定义一个字符串，用于存放已经执行的操作的downLoad信息
@property (nonatomic,copy)NSString *currentIcon;

//定义一个操作缓存字典
@property (nonatomic,strong)NSMutableDictionary *operationDict;


@end

@implementation ViewController

-(NSArray *)dataArray
{
    if (nil == _dataArray)
    {
        _dataArray = [AppModel appArrayList];
    }
    
    return _dataArray;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self Demo];
}

-(void)Demo
{
    //(1)生成随机数
    int num = arc4random_uniform((int)self.dataArray.count);
    
    //(2)根据随机数来获取数组中数据
    AppModel *model = self.dataArray[num];
    
    //如何判断之前是否点击:变量记录之前图片下载地址,再次点击,生成新的下载地址,判断之前的地址与当前modleicon地址石头一致,如果不同->之前一定是点击过的
    if (!([_currentIcon isEqualToString:model.icon]))
    {
        //取消之前的操作
        //(1)根据_currentIcon信息从操作缓存中取出之前的操作
        DownLoadImage *oldOperation = self.operationDict[_currentIcon];
        
        //如果存在
        if (oldOperation)
        {
            //取消之前旧的操作
            oldOperation.cancelHasDone = YES;
        }
        
    }
    
    //更新_currentIcon信息
    _currentIcon = model.icon;
    
    //(3)根据数据信息，把数据信息填入到操作中，生成新的操作
    DownLoadImage *downLoadImg = [DownLoadImage DownLoadImageWith:model.icon andBlock:^(UIImage *image) {
        
        self.showImage.image = image;
        
        //将操作从缓存字典中删除掉
        [self.operationDict removeObjectForKey:model.icon];
        
    }];
    
    //将操作加入到操作缓存中
    [self.operationDict setObject:downLoadImg forKey:model.icon];
    
    //(4)将操作加入到队列中
    [self.queue addOperation:downLoadImg];

}



@end
