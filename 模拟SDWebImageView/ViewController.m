//
//  ViewController.m
//  模拟SDWebImageView
//
//  Created by 王炯 on 16/6/12.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"
#import "UIImageView+DownLoadImage.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@property (nonatomic,strong)NSArray<AppModel *> *dataArray;



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
    
    
    //启动下载图片更新到showImage的任务
    [self.showImage DownLoadImageWithUrlStr:model.icon];
}



@end
