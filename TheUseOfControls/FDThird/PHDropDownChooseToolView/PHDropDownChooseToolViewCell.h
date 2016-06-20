//
//  PHDropDownChooseToolViewCell.h
//  DropDownRefresh
//
//  Created by 大麦 on 16/4/9.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHDropDownChooseToolViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLabelConstraintLeftSide;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLabelConstraintRightSide;
@property (strong, nonatomic) IBOutlet UIImageView *bottomImageLine;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomLineConstraintLeftSide;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomLineConstraintRightSide;

//添加内容
-(void)pushCellWithSting:(NSString *)string;//添加内容
-(void)pushCellBottomViewLineBackground:(UIColor *)color;//修改bottom颜色
-(void)pushTitleLabelLeftSide:(float)leftSide andRightSide:(float)rightSide;//修改title左右边距
-(void)pushBottomLineLeftSide:(float)leftSide andRightSide:(float)rightSide;//修改line左右边距
@end
