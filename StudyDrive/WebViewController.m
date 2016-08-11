//
//  WebViewController.m
//  StudyDrive
//
//  Created by ruanjianjulebu on 16/4/22.
//  Copyright (c) 2016年 ruanjianjulebu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    UIWebView *_webView;
}
@end

@implementation WebViewController
-(instancetype)initWithUrl:(NSString *)url{
    self =[super init];
    if(self){
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        _webView=[[UIWebView alloc ]initWithFrame:self.view.frame];
        [_webView loadRequest:request];
        [self.view addSubview:_webView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
