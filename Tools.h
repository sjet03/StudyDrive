//
//  Tools.h
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/3/30.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tools : NSObject
+(NSArray *)getAnswerWithString:(NSString *)str;
+(CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize:(CGSize)size;
@end
