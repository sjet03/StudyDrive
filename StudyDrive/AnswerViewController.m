//
//  AnswerViewController.m
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/3/29.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"
@interface AnswerViewController ()
{
    AnswerScrollView *view;
    SelectModelView *modelView;
    SheetView *sheetView;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
      [self creatData];
  
    [self.view addSubview:view];
    [self creatToolBar];
    [self creatModelView];
    [self creatSheetView];
}
-(void)creatData{
    if (_type==1) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        NSArray *array=[MyDataManager getData:answer];
        for (int i=0; i<array.count-1; i++) {
            AnswerModel *model=array[i];
            if ([model.pid intValue]==_number+1) {
                [arr addObject:model];
            }
        }

      view=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60)withDataArray:arr];
    
    }else if (_type==2){
  view=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60)withDataArray:[MyDataManager getData:answer]];
    }
    else{
      NSMutableArray *temArr = [[NSMutableArray alloc]init];
      NSArray *array=[MyDataManager getData:answer];
      NSMutableArray *dataArray=[[NSMutableArray alloc]init];
      [temArr addObjectsFromArray:array];
      for (int i=0; i<temArr.count; ) {
          int index=arc4random()%(temArr.count);
          [dataArray addObject:temArr[index]];
          [temArr removeObjectAtIndex:index];
      }
       view=[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60)withDataArray:dataArray];
    }
}
-(void)creatSheetView{
    sheetView=[[SheetView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width,self.view.frame.size.height-80) withSuperView:self.view];
    [self.view addSubview:sheetView];
}
-(void)creatModelView{
    modelView = [[SelectModelView alloc]initWithFrame:self.view.frame addTouch:^(SelectModel model){
        NSLog(@"当前模式:%d",model);
    }];
    [self.view addSubview:modelView];
    modelView.alpha=0;
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    self.navigationItem.rightBarButtonItem=item;
}
-(void)modelChange:(UIBarButtonItem *)item{
    [UIView animateWithDuration:0.3 animations:^{
        modelView.alpha=1;
    }];
}
-(void)creatToolBar{
    UIView *barView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barView.backgroundColor=[UIColor whiteColor];
    NSArray *arr=@[@"11111",@"查看答案",@"收藏本题"];
    for (int i=0; i<3; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.view.frame.size.width/3*i+self.view.frame.size.width/3/2-20, 0, 36, 36) ;
        //正常状态的图片
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",16+i]] forState:UIControlStateNormal];
        //高亮状态下的图片
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",16+i]] forState:UIControlStateHighlighted];
        
        btn.tag=301+i;
        [btn addTarget:self action:@selector(clicklToolBar:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x, 40, 40, 18)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=arr[i];
        label.font=[UIFont systemFontOfSize:14];
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    [self.view addSubview:barView];
}
-(void)clicklToolBar:(UIButton *)btn{
    switch (btn.tag) {
        case 301:{
            [UIView animateWithDuration:0.3 animations:^{
                sheetView.frame=CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
            }];
        }break;
        case 302://查看答案
        {
            if([view.hadAnswerArray[view.currentPage] intValue]!=0){
                return;
            }
            else{
                AnswerModel *model=[view.dataArray objectAtIndex:view.currentPage];
                NSString *answer=model.manswer;
                char an=[answer characterAtIndex:0];
                [view.hadAnswerArray replaceObjectAtIndex:view.currentPage withObject:[NSString stringWithFormat:@"%d",an-'A'+1]];
                [view reloadData];
            }
           
    }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
