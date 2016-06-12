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
    
    //(3)根据数据信息，把数据信息填入到操作中，生成新的操作
    DownLoadImage *downLoadImg = [DownLoadImage DownLoadImageWith:model.icon andBlock:^(UIImage *image) {
        self.showImage.image = image;
    }];
    
    
    
    //(4)将操作加入到队列中
    [self.queue addOperation:downLoadImg];

}



@end
