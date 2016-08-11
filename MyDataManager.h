//
//  MyDataManager.h
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/3/29.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import <Foundation/Foundation.h>
//设置枚举
typedef enum{
    chapter,//章节练习数据
    answer,//答题数据
}DataType;
@interface MyDataManager : NSObject
+(NSArray *)getData:(DataType)type;
@end
