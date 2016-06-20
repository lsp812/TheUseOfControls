//
//  PHDropDownChooseToolView.h
//  DropDownRefresh
//
//  Created by 大麦 on 16/4/9.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PHDropDownChooseTitleLabelAlignmentLeft,
    PHDropDownChooseTitleLabelAlignmentCenter,
    PHDropDownChooseTitleLabelAlignmentRight
} PHDropDownChooseTitleLabelAlignment;

@class PHDropDownChooseToolView;
@protocol PHDropDownChooseToolViewDelegate <NSObject>

#pragma mark -- 代理方法
//代理方法.返回的是点击的第几项(从0开始。本质是数组的下标)。
-(void)phDropDownList:(PHDropDownChooseToolView *)dropDownList andClickIndex:(NSInteger)index;

@end

@interface PHDropDownChooseToolView : UIView

@property (weak, nonatomic) id<PHDropDownChooseToolViewDelegate> delegate;


#pragma mark -- 初始化方法的设置
//初始化的方法
+(PHDropDownChooseToolView *)sharedInstance;

#pragma mark -- 显示的方法
-(void)showPHView:(BOOL)animal;
#pragma mark -- 消失方法
-(void)dismissPHView:(BOOL)animal;
//没有默认值
-(void)showPHChooseListWithArray:(NSArray *)array withFrame:(CGRect)frame;
//有默认数值的
-(void)showPHChooseListWithArray:(NSArray *)array withFrame:(CGRect)frame andSelectString:(NSString *)selectString;
//有默认数值的
-(void)showPHChooseListWithArray:(NSArray *)array withFrame:(CGRect)frame andSelectIndex:(NSInteger)selectIndex;

#pragma mark -- 遮罩层的设置
//设置遮罩的透明度(默认是0.5)
-(void)setMaskViewAlaph:(float)alpha;
//设置遮罩的背景色(默认是黑色)
-(void)setMaskViewBackgroundColor:(UIColor *)backgroundColor;
//设置动画时间
-(void)setAnimaltime:(float)animalTime;

#pragma mark -- 设置cell的属性
-(void)setCellTitleLabelSelectedTextColor:(UIColor *)selectedTextColor;//文字选中颜色
-(void)setCellTitleLabelNormalTextColor:(UIColor *)normalColor;//文字普通颜色
-(void)setCelltitleLabelFont:(UIFont *)textFont;//文字的字体大小.
-(void)setCellTitleLabelAlignment:(PHDropDownChooseTitleLabelAlignment)alignment;//设置文字的对齐方式
-(void)setCellBottomLineColor:(UIColor *)color;//底部线的颜色
//修改title左右边距
-(void)setCellTitleLabelLeftSide:(float)leftSide;
-(void)setCellTitleLabelRightSide:(float)rightSide;
-(void)setCellTitleLabelLeftSide:(float)leftSide andRightSide:(float)rightSide;
//修改line左右边距
-(void)setCellBottomLineLeftSide:(float)leftSide;
-(void)setCellBottomLineRightSide:(float)rightSide;
-(void)setCellBottomLineLeftSide:(float)leftSide andRightSide:(float)rightSide;
//设置字体的左右边距.
//设置线的左右边距.


@end
