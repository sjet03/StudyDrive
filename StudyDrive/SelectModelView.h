//
//  SelectModelView.h
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/4/21.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    testModel,
    lookingModel
}SelectModel;
typedef void  (^SelectTouch)();
@interface SelectModelView :  UIView
@property(nonatomic,assign)SelectModel model;
-(SelectModelView *)initWithFrame:(CGRect)frame addTouch:(SelectTouch)touch;
@end
