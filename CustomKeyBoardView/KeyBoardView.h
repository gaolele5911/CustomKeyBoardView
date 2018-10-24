//
//  KeyBoardView.h
//  自定义键盘
//
//  Created by 王洋 on 2018/10/19.
//  Copyright © 2018年 王洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyBoardView : UIView
@property(copy,nonatomic)void(^KeyBoardBlock)(NSString *CodeStr);
@property(strong,nonatomic)UITextField *handleTextFiled;
@end
