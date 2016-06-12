//
//  AppModel.m
//  09-异步下载
//
//  Created by 王炯 on 16/6/11.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(instancetype)AppModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

#warning 泛型数组，数组中的数据只能是AppModel类型
+(NSArray<AppModel *> *)appArrayList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
    
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (NSDictionary *dict in tempArray)
    {
        AppModel *model = [AppModel AppModelWithDict:dict];
        
        [mutableArray addObject:model];
    }
    
    //返回一个不可变数组
    return mutableArray.copy;
}


@end
