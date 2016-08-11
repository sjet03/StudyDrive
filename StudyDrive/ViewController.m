//
//  ViewController.m
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/3/9.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//
#import "selectview.h"
#import "ViewController.h"
#import "FirstViewController.h"
#import "SubjectTwoViewController.h"
#import "WebViewController.h"
@interface ViewController ()
{
    selectview *_selectview;
    __weak IBOutlet UIButton *selectBtn;
}
@end

@implementation ViewController
- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _selectview.alpha=1;
            }];
        }
            break;
        case 101://科目一;跳转到tableview
        {
            [self.navigationController pushViewController:[[FirstViewController alloc]init] animated:YES];
        }
            break;
        case 102:
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            [self.navigationController pushViewController:[[SubjectTwoViewController alloc]init] animated:YES];
        }
            break;
        case 103:
        {        }
            break;
        case 104:
        {
           
        }
            break;
        case 105:
        {
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            [self.navigationController pushViewController:[[WebViewController alloc]initWithUrl:@"http://zhinan.jxedt.com"] animated:YES];
        }
            break;
        case 106:
        {
                  }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _selectview =[[selectview alloc]initWithFrame:self.view.frame andBtn:selectBtn];
    _selectview.alpha=0;
    [self.view addSubview:_selectview];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
