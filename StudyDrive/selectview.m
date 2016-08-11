//
//  selectview.m
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/3/13.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import "selectview.h"

@implementation selectview
{
    UIButton *_button;
}
//instancetype表示方法所在类的类型
-(instancetype)initWithFrame:(CGRect)frame andBtn:(UIButton *)btn{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _button=btn;
        [self creatBtn];
        
    }
    return self;
}

//创建4个button
-(void)creatBtn{
    for(int i=0;i<4;i++){
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(self.frame.size.width/4*i+self.frame.size.width/4/2-30,self.frame.size.height-80,60, 60);
        //设置图片显示，常规状态下显示
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]] forState:UIControlStateNormal];
        //设置button的点击事件
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
         [self addSubview:btn];
    }
}

//点击页面，页面消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;}];
    }
//button点击事件，根据buton的状态设置背景图案
-(void)click:(UIButton *)btn{
    [_button setImage:[btn backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    }];
}
@end
