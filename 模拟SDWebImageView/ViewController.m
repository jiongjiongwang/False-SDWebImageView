//
//  ViewController.m
//  模拟SDWebImageView
//
//  Created by 王炯 on 16/6/12.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"
#import "DownLoadImgManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@property (nonatomic,strong)NSArray<AppModel *> *dataArray;



//定义一个字符串，用于存放已经执行的操作的downLoad信息
@property (nonatomic,copy)NSString *currentIcon;


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
        
        //开启取消图片下载服务
        [[DownLoadImgManager shardManager] cancelDownWithImgStr:_currentIcon];
    }
    
    //更新_currentIcon信息
    _currentIcon = model.icon;
    
    
    //开启下载图片服务
    [[DownLoadImgManager shardManager] DownloadImgWithImgStr:model.icon andBlock:^(UIImage *image) {
       
        self.showImage.image = image;
    }];
    

}



@end
