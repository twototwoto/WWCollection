//
//  WYWTitleBarView.h
//  WWCollection
//
//  Created by WYW on 2018/3/30.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYWTitleBarView : UIView

/**要显示的标题数组*/
@property (nonatomic,copy) NSArray *titleArray;

/**文本常态颜色*/
@property (nonatomic,strong) UIColor *textNormalColor;

/**文本选中颜色*/
@property (nonatomic,strong) UIColor *textSelectedColor;

@property (nonatomic,copy) void(^btnBlock)(NSInteger tag);

//承载所有button的数组
@property (nonatomic,strong) NSMutableArray <UIButton *>*buttonArrayM;

+ (instancetype)titleBarViewWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray textNormalColor:(UIColor *)textNormalColor textSelectedColor:(UIColor *)textSelectedColor;

#pragma mark - 按钮点击
- (void)btnClick:(UIButton *)sender;
@end
