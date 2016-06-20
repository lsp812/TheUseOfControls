//
//  PHDropDownChooseToolViewCell.m
//  DropDownRefresh
//
//  Created by 大麦 on 16/4/9.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "PHDropDownChooseToolViewCell.h"

@implementation PHDropDownChooseToolViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//添加内容
-(void)pushCellWithSting:(NSString *)string
{
    self.titleLabel.text = string;
}
//添加
-(void)pushCellBottomViewLineBackground:(UIColor *)color
{
    self.bottomImageLine.backgroundColor = color;
}

-(void)pushTitleLabelLeftSide:(float)leftSide andRightSide:(float)rightSide//修改title左右边距
{
    self.titleLabelConstraintLeftSide.constant = leftSide;
    self.titleLabelConstraintRightSide.constant = rightSide;
}
-(void)pushBottomLineLeftSide:(float)leftSide andRightSide:(float)rightSide//修改line左右边距
{
    self.bottomLineConstraintLeftSide.constant = leftSide;
    self.bottomLineConstraintRightSide.constant = rightSide;
}
@end
