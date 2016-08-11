//
//  FirstViewController.m
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/3/15.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "TestViewController.h"
#import "MyDataManager.h"
#import "AnswerViewController.h"
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSArray *_dataArray;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    使坐标从导航栏一下开始算起
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
   
    _dataArray=@[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真模拟考试"];
    [self creatTableView];
    [self creatView];
}


//创建tablebview
-(void)creatTableView{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    [self.view addSubview:_tableview];
}

-(void)creatView{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height-64-140, 300, 30)];
    label.textAlignment=NSTextAlignmentCenter;
    NSLog(@"fddf");
    label.text=@"*************我的考试分析*************";
    [self.view addSubview:label];
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-100, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",12+i ]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        NSLog(@"第%d个btn",i);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview delegate
//cellforrowindexpath 
//设置 tableview的段数section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 设置多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
//设置一个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   // 声明一个静态字符串
//绘制特有的cell
    static NSString *cellID = @"FirstTableViewCell";
    
    FirstTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        //插入表单元 通过loadnibnamed类方法传入xib文件中的cell样式 进行创建
        cell=[[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
    }
    cell.myImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",indexPath.row+7]];cell.myLabel.text=_dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            TestViewController *con=[[TestViewController alloc]init];
            con.dataArray=[MyDataManager getData:chapter];
            con.title=@"章节练习";
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:con animated:YES];
            
        }
            break;
        case 1:{
            AnswerViewController *answer=[[AnswerViewController alloc]init];
            answer.type=2;
            [self.navigationController pushViewController:answer animated:YES];
        }break;
        case 2:{
            AnswerViewController *answer=[[AnswerViewController alloc]init];
            answer.type=3;
            [self.navigationController pushViewController:answer animated:YES];
        }
        default:
            break;
    }
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
