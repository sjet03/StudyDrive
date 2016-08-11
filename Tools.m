//
//  Tools.m
//  StudyDrive
//解析字符串
//  Created by ruanjianjulebu on 16/3/30.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import "Tools.h"

@implementation Tools
//接收解析完成的数据
+(NSArray *)getAnswerWithString:(NSString *)str{
    NSMutableArray *array=[[NSMutableArray alloc]init];
//    分割字符串
    NSArray *arr=[str componentsSeparatedByString:@"<BR>"];
    
    [array addObject:arr[0]];
//   ABCD已经有了  从第二个字符串开始添加
    for (int i=0; i<4; i++) {
        [array addObject:[arr[i+1] substringFromIndex:2]];

    }
    return array;
}
+(CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize :(CGSize)size{
    CGSize newSize=[str sizeWithFont:font constrainedToSize:size];
    return newSize;
                     }
@end
