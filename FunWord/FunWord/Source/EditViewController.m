//
//  EditViewController.m
//  FunWord
//
//  Created by elvis on 15/1/19.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, strong)UIImageView *backView;
@property(nonatomic, strong)UIControl   *disappearTextControl;
@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.disappearTextControl];
    [self loadContent];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadDefaultSetting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dissappearAction:(id)sender {
    [_textView resignFirstResponder];
}

#pragma mark - Getter 
- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 75, self.view.frame.size.width - 40, 150)];
        _textView.font = [UIFont systemFontOfSize:16];
    }
    return _textView;
}
- (UIControl *)disappearTextControl {
    if (!_disappearTextControl) {
        _disappearTextControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 230, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        [_disappearTextControl addTarget:self action:@selector(dissappearAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _disappearTextControl;
}
- (UIImageView *)backView{
    if (_backView == nil) {
        _backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edit_bg"]];
        _backView.frame = CGRectMake(10, 70, self.view.frame.size.width - 20, 160);
    }
    return _backView;
}

#pragma mark - Privte
-(void)loadContent{
    self.navigationItem.title = @"Edit";
}

@end
