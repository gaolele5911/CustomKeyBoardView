//
//  ViewController.m
//  自定义键盘
//
//  Created by 王洋 on 2018/10/19.
//  Copyright © 2018年 王洋. All rights reserved.
//

#import "ViewController.h"
#import "KeyBoardView.h"
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property(nonatomic,strong)dispatch_source_t timer;
@property (weak, nonatomic) IBOutlet UITextField *textFiled2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    KeyBoardView *keyBoardView = [[KeyBoardView alloc]init];
    keyBoardView.handleTextFiled = self.textFiled;
    self.textFiled.inputView = keyBoardView;
    
    KeyBoardView *keyBoardView2 = [[KeyBoardView alloc]init];
    keyBoardView2.handleTextFiled = self.textFiled2;
    self.textFiled2.inputView = keyBoardView2;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
