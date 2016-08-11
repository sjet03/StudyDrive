//
//  SubjectTwoViewController.m
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/4/22.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import "SubjectTwoViewController.h"
#import "SubjectTwoTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
@interface SubjectTwoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation SubjectTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *cellId=@"SubjectTwoTableViewCell";
    SubjectTwoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil]lastObject];
       
    }
    cell.titleImageView.image=[UIImage imageNamed:@"203.png"];
     cell.theTitleLabel.text=[NSString stringWithFormat:@"视频:%ld",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"shipin" ofType:@"mp4"];
    NSURL *url=[NSURL fileURLWithPath:path];
    MPMoviePlayerViewController *movie=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
    movie.moviePlayer.shouldAutoplay=YES;
    [self.navigationController pushViewController:movie animated:YES];
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
