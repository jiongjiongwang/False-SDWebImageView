//
//  AppModel.h
//  09-异步下载
//
//  Created by 王炯 on 16/6/11.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *download;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)AppModelWithDict:(NSDictionary *)dict;


+(NSArray *)appArrayList;

@end
