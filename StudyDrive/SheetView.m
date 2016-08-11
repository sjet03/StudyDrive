//
//  SheetView.m
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/6/2.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import "SheetView.h"

@interface SheetView()
{
    UIView *_superView;
    UIView *_backView;
    BOOL _startMoving;
    float _height;
    float _width;
    float _y;
}

@end
@implementation SheetView
-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor redColor];
        _height=frame.size.height;
        _width=frame.size.width;
        _y=frame.origin.y;
        _superView=superView;
        [self creatView];
    }
    return self;
}
-(void)creatView{
    _backView=[[UIView alloc]initWithFrame:_superView.frame];
    _backView.backgroundColor=[UIColor whiteColor];
    _backView.alpha=0;
    [_superView addSubview:_backView];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    if(point.y<25){
        _startMoving=YES;
    }if (_startMoving &&self.frame.origin.y>_y-_height) {
        self.frame=CGRectMake(0, [self convertPoint:point toView:_superView].y , _width, _height);   }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    _startMoving=NO;
    if (self.frame.origin.y>_y-_height/2) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(0, _y, _width, _height);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(0, _y-_height, _width, _height);
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
