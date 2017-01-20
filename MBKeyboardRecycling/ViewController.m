//
//  ViewController.m
//  MBKeyboardRecycling
//
//  Created by yindongbo on 17/1/18.
//  Copyright © 2017年 Nxin. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+KeyboardManager.h"
@interface ViewController ()
<
UITextFieldDelegate
>

@property (strong, nonatomic) IBOutlet UITextField *aTestField;

@property (strong, nonatomic) IBOutlet UITextField *bTestField;

@property (strong, nonatomic) IBOutlet UITextField *cTestField;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.scrollView addGestureRecognizer:tap];
    self.scrollView.contentSize = CGSizeMake(0, 0);
    
    self.aTestField.delegate = self;
    self.bTestField.delegate = self;
    
    [self mb_startKeyboardListening];
}

- (void)tapView:(UIGestureRecognizer *)gest {
    [self.scrollView endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"123123");
}
@end
