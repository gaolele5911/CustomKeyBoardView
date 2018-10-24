//
//  KeyBoardView.m
//  自定义键盘
//
//  Created by 王洋 on 2018/10/19.
//  Copyright © 2018年 王洋. All rights reserved.
//

#import "KeyBoardView.h"

#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface KeyBoardView()
{
    UIButton *_lastNumBtn;
}

@end
@implementation KeyBoardView
-(instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, KScreenWidth, 260);
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    
    return self;
}
- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 35)];
    toolbar.tintColor = [UIColor blackColor];
    toolbar.backgroundColor = [UIColor whiteColor];
//    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextTextField)];
//    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(prevTextField)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[ space, bar];
    return toolbar;
}


-(void)setUpUI {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    
    self.backgroundColor = [UIColor orangeColor];
    NSString *ZMStr = @"1 2 3 4 5 6 7 8 9 0 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z";
    NSArray *ZMArray = [ZMStr componentsSeparatedByString:@" "];
    for (int i = 0; i < ZMArray.count; i++) {
        UIButton *numBtn = [[UIButton alloc]init];
        numBtn.backgroundColor = [UIColor whiteColor];
        [self addSubview:numBtn];
        [numBtn setTitle:[NSString stringWithFormat:@"%@",ZMArray[i]] forState:UIControlStateNormal];
        [self addSubview:numBtn];
        
        CGFloat MarginX = 5;
        CGFloat MarginY = 10;
        CGFloat buttonW = (KScreenWidth - 11 * MarginX) / 10;
        CGFloat buttonY = (self.frame.size.height - 5 * MarginY) / 4;
        
        CGFloat row = 0;
        CGFloat line = 0;
        if (i < 29) {
            row = i % 10;
            line = i / 10;
        }else {
            row = i % 29;
            line = 3;
        }
        
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numBtn addTarget:self action:@selector(numBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if(i < 20){
            numBtn.frame = CGRectMake(MarginX + (buttonW + MarginX) * row,MarginY + (buttonY + MarginY) * line,buttonW,buttonY);
        }else if(i >= 20 && i < 29){
            numBtn.frame = CGRectMake(MarginX + buttonW / 2 + (buttonW + MarginX) * row,MarginY + (buttonY + MarginY) * line,buttonW,buttonY);
        }else {
            numBtn.frame = CGRectMake(buttonW + 2 * MarginX + buttonW / 2 + (buttonW + MarginX) * row,MarginY + (buttonY + MarginY) * line,buttonW,buttonY);
        }
        _lastNumBtn = numBtn;
        numBtn.layer.cornerRadius = 5;
        [numBtn.layer masksToBounds];
    }
    
    CGFloat deleteBtnW = 40;
    CGFloat deleteBtnH = 40;
    UIButton *deleteBtn = [[UIButton alloc]init];
    deleteBtn.backgroundColor = [UIColor redColor];
    [self addSubview:deleteBtn];
    [deleteBtn setTitle:@"删" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(numBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.frame = CGRectMake(KScreenWidth - 40 - 5, _lastNumBtn.frame.origin.y + 10, deleteBtnW, deleteBtnH);
    deleteBtn.layer.cornerRadius = 5;
    [deleteBtn.layer masksToBounds];
    
}
-(void)setHandleTextFiled:(UITextField *)handleTextFiled {
    _handleTextFiled = handleTextFiled;
    _handleTextFiled.inputAccessoryView = [self addToolbar];
}

#pragma mark --相应键盘的通知事件
- (void)changeKeyBoard:(NSNotification *)notification{
    UIView *mainView = [[UIApplication sharedApplication] keyWindow];

    NSLog(@"%@",notification);
    //获取userInfo信息
    NSDictionary *userInfo = notification.userInfo;
    //获取要移动控件的transForm
    CGAffineTransform transForm = mainView.transform;
    
    //获取移动的位置 屏幕的高度 - 最终显示的frame的Y = 移动的位置
    //1. 获取键盘最终显示的y
    NSValue *value = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect endFrame = [value CGRectValue];
    CGFloat moveY = - (mainView.frame.size.height - endFrame.origin.y);
    
    //移动
    transForm = CGAffineTransformMakeTranslation(0, moveY);
    
    //执行动画移动
    [UIView animateWithDuration:[userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        mainView.transform = transForm;
    }];
    
    
}
-(void)numBtnAction:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"删"]) {
        [self.handleTextFiled deleteBackward];
    }else {
        [self.handleTextFiled insertText:btn.titleLabel.text];
    }

}
-(void)textFieldDone {
    [_handleTextFiled endEditing:YES];
}

@end
