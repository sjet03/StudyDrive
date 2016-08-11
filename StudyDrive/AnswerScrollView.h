//
//  AnswerScrollView.h
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/3/29.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerScrollView : UIView
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array;
@property(nonatomic,assign,readonly)int currentPage;
@property(nonatomic ,strong)NSMutableArray *hadAnswerArray;
@property(nonatomic,strong)NSArray *dataArray;
-(void)reloadData;
@end
