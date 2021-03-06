//
//  AnswerScrollView.m
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/3/29.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tools.h"
#define SIZE self.frame.size
@interface AnswerScrollView()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
}

@end
@implementation AnswerScrollView

{
    UIScrollView * _scrollView;
    UITableView *_leftTableView;
    UITableView *_mainTableView;
    UITableView *_rightTableView;
}
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array{
    self=[super initWithFrame:frame];
    if(self){
        
        _currentPage=0;
        self.dataArray=[[NSArray alloc]initWithArray:array];
        _hadAnswerArray=[[NSMutableArray alloc]init];
        for (int i=0; i<array.count; i++) {
            [_hadAnswerArray addObject:@"0"];
        }
//        实例化scollview数据源和代理
        _scrollView =[[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate=self;
        _leftTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.dataSource=self;
        _mainTableView.dataSource=self;
        _rightTableView.dataSource=self;
        _leftTableView.delegate=self;
        _mainTableView.delegate=self;
        _rightTableView.delegate=self;
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces=NO;
        if (_dataArray.count>1) {
            _scrollView.contentSize=CGSizeMake(SIZE.width*2, 0);
        }
        [self creatView];
                      
    }
        return self;
}

-(void)creatView{
    _leftTableView.frame=CGRectMake(0, 0, SIZE.width, SIZE.height);
    _mainTableView.frame=CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    _rightTableView.frame=CGRectMake(SIZE.width*2,0 , SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_mainTableView];
    [_scrollView addSubview:_rightTableView];
    [self addSubview:_scrollView];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AnswerModel *model=[self getTheFitModel:tableView];
   
        NSString *str = [NSString stringWithFormat:@"答案解析：%@",model.mdesc] ;
        UIFont *font =[UIFont systemFontOfSize:16];
        return  [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    AnswerModel *model=[self getTheFitModel:tableView];
    CGFloat height;
    if ([model.mtype intValue]==1) {
           NSString *str = [[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font =[UIFont systemFontOfSize:16];
       height= [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        NSString *str = model.mquestion;
        UIFont *font =[UIFont systemFontOfSize:16];
        height= [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }
    if (height<=80) {
        return 80;
    }else{
        return height;
    }
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AnswerModel *model=[self getTheFitModel:tableView];
    CGFloat height;
    NSString *str;
    
    str = [NSString stringWithFormat:@"答案解析：%@",model.mdesc];
        UIFont *font =[UIFont systemFontOfSize:16];
        height= [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    label.text= str;
    label.font=[UIFont systemFontOfSize:16];
    label.numberOfLines=0;
    label.textColor=[UIColor greenColor];
    [view addSubview:label];
    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if ([_hadAnswerArray[page-1] intValue]!=0) {
        return view;
    }
    return nil;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    AnswerModel *model=[self getTheFitModel:tableView];
    CGFloat height;
    NSString *str;
    if ([model.mtype intValue]==1) {
      str = [[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font =[UIFont systemFontOfSize:16];
        height= [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        str = model.mquestion;
        UIFont *font =[UIFont systemFontOfSize:16];
        height= [Tools getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }


    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    label.text= [NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str];
    label.font=[UIFont systemFontOfSize:16];
    label.numberOfLines=0;
    [view addSubview:label];
    return view;
                                               
}

//获取答案页数

-(int)getQuestionNumber:(UITableView *)tableView andCurrentPage:(int)page{
    if (tableView==_leftTableView&&page==0) {
        return 1;
        
    }else if (tableView==_leftTableView&&page>0){
        return page;
    }else if (tableView==_mainTableView&&page>0&&page<_dataArray.count-1){
        return page+1;
    }
    else if (tableView==_mainTableView&&page==0){
        return 2;
    }
    else if (tableView==_mainTableView&&page>0&&page==_dataArray.count-1){
        return page;
    }
    else if (tableView==_rightTableView&&page<_dataArray.count-1){
        return page+2;
    }else if (tableView==_rightTableView&&page==_dataArray.count-1) {
        return page;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if([_hadAnswerArray[page-1]intValue]!=0){
        return;
    }else{
        [_hadAnswerArray replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    }
    [self reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"AnswerTableViewCell";
    AnswerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"AnswerTableViewCell" owner:self options:nil]lastObject];
        cell.numberLabel.layer.masksToBounds=YES;
        cell.numberLabel.layer.cornerRadius=10;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    cell.numberLabel.text=[NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    AnswerModel *model=[self getTheFitModel:tableView];
   
//    取选项
    if ([model.mtype intValue]==1) {
        cell.answerLabel.text=[[Tools getAnswerWithString:model.mquestion]objectAtIndex:indexPath.row+1];
    }
    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if ([_hadAnswerArray[page-1] intValue]!=0) {
        if ([model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]) {
            cell.numberImage.hidden=NO;
            cell.numberImage.image=[UIImage imageNamed:@"19.png"];
        }
        else if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+[_hadAnswerArray[page-1] intValue]-1]]&&indexPath.row==[_hadAnswerArray[page-1] intValue]-1) {
            cell.numberImage.image=nil;
            cell.numberImage.hidden=NO;
            cell.numberImage.image=[UIImage imageNamed:@"20.png"];
        }else{
            cell.numberImage.hidden=YES;
        }
    }
    else{
        cell.numberImage.hidden=YES;
    }
    return cell;
}
-(AnswerModel *)getTheFitModel:(UITableView *)tableView{
    AnswerModel *model;
    //只需创建3个tableview，第一个，中间的，最后一个，第一个有两种方式，中间的有三种方式，最后一种有两种
    
    
    if(tableView==_leftTableView&&_currentPage==0){
        model =_dataArray[_currentPage];
        
    }
    else if(tableView==_leftTableView&&_currentPage>0){
        model=_dataArray[_currentPage-1];
    }
    else if(tableView==_mainTableView&&_currentPage==0){
        model=_dataArray[_currentPage+1];
        
    }else if(tableView==_mainTableView&&_currentPage>0&&_currentPage<_dataArray.count-1){
        model=_dataArray[_currentPage];
        
    }else if (tableView==_mainTableView&&_currentPage==_dataArray.count-1){
        model=_dataArray[_currentPage-1];
    }else if (tableView==_rightTableView&&_currentPage==_dataArray.count-1){
        model=_dataArray[_currentPage];
    }else if (tableView==_rightTableView&&_currentPage<_dataArray.count-1){
        model=_dataArray[_currentPage+1];
    }
    return model;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint currentOffset=scrollView.contentOffset;
    int page=(int)currentOffset.x/SIZE.width;
    if (page<_dataArray.count-1&&page>0) {
        _scrollView.contentSize=CGSizeMake(currentOffset.x+SIZE.width*2, 0);
        _mainTableView.frame=CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        _leftTableView.frame=CGRectMake(currentOffset.x-SIZE.width,0 , SIZE.width, SIZE.height);
        _rightTableView.frame=CGRectMake(currentOffset.x+SIZE.width, 0, SIZE.width, SIZE.height);
    }
    _currentPage=page;
    [self reloadData];
}
-(void)reloadData{
    [_leftTableView reloadData];
    [_rightTableView reloadData];
    [_mainTableView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
