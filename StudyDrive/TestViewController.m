//
//  TestViewController.m
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/3/16.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import "TestViewController.h"
#import "TestTableViewCell.h"
#import "TestSelectModel.h"
#import "AnswerViewController.h"
@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self creatTableView];
}

-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

#pragma mark - delega
//有几个section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;

}

//每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"TestTableViewCell";
    TestTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.numberLabel.layer.masksToBounds=YES;
        cell.numberLabel.layer.cornerRadius=8;
    }
    TestSelectModel *model=_dataArray[indexPath.row];
    cell.numberLabel.text=model.pid;
    cell.titleLable.text=model.pname;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerViewController *avc=[[AnswerViewController alloc]init];
    avc.number=indexPath.row;
    avc.type=1;
    [self.navigationController pushViewController:[[AnswerViewController alloc]init] animated:YES];
    
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
