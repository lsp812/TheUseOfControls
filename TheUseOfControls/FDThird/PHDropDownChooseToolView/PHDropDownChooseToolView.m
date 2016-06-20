//
//  PHDropDownChooseToolView.m
//  DropDownRefresh
//
//  Created by 大麦 on 16/4/9.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "PHDropDownChooseToolView.h"
#import "PHDropDownChooseToolViewCell.h"
@interface PHDropDownChooseToolView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *phTableView;//列表
@property (nonatomic, strong) NSMutableArray *dataSourceArray;//数据源
@property (nonatomic, strong) UIButton *backgroundButton;//半透明大背景图
@property (nonatomic, assign) BOOL isHaveDefaultString;//是否有默认值
@property (nonatomic, assign) int  selectedIndex;//默认的下标

@property (nonatomic, strong) UIColor *normalTextColor;//字体的普通颜色
@property (nonatomic, strong) UIColor *selectedTextColor;//字体的选中颜色
@property (nonatomic, assign) float maskButtonAlpha;//遮罩层的透明度

@property (nonatomic, strong) UIColor *bottomColor;//底部线的颜色
@property (nonatomic, assign) PHDropDownChooseTitleLabelAlignment alignment;//字体的对齐方式
@property (nonatomic, assign) UIFont *titleLabelFont;//字体大小

@property (nonatomic, assign) float titleLabelLeftSide;//lablel的左边距
@property (nonatomic, assign) float titleLabelRightSide;//label的右边距
@property (nonatomic, assign) float bottomLeftSide;//line的左边距
@property (nonatomic, assign) float bottomRightSide;//line的右边距

@property (nonatomic, assign) float animalTime;

@property (nonatomic, assign) BOOL isShow;

@end

#define PHTABLEVIEW_CELLHEIGHT 38

@implementation PHDropDownChooseToolView

#pragma mark -- 视图的初始化方法
+(PHDropDownChooseToolView *)sharedInstance
{
    static PHDropDownChooseToolView *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.backgroundColor = [UIColor clearColor];
        sharedInstance.backgroundButton = [sharedInstance getBackgroundButton];
        sharedInstance.phTableView = [sharedInstance getTableView];
        //
        sharedInstance.dataSourceArray = [NSMutableArray array];
        sharedInstance.isHaveDefaultString = NO;
        sharedInstance.selectedIndex = 0;
//        sharedInstance.normalTextColor = [ColorUtility colorWithHexString:@"000000"];
//        sharedInstance.selectedTextColor = [ColorUtility colorWithHexString:@"ea0f51"];
        sharedInstance.normalTextColor = [UIColor grayColor];
        sharedInstance.selectedTextColor = [UIColor redColor];
        sharedInstance.bottomColor = [UIColor colorWithRed:229.0/255.0 green:230.0/255.0 blue:231.0/255.0 alpha:1.0];
        sharedInstance.alignment = PHDropDownChooseTitleLabelAlignmentLeft;
        sharedInstance.titleLabelFont = [UIFont systemFontOfSize:12.0];
        //
        sharedInstance.titleLabelLeftSide = 15;
        sharedInstance.titleLabelRightSide = 15;
        sharedInstance.bottomLeftSide = 15;
        sharedInstance.bottomRightSide = 0;
        //
        sharedInstance.animalTime = 0.5;
        //
        sharedInstance.isShow = NO;//未展示
    });
    
    return sharedInstance;
}
#pragma mark -- 显示的方法
-(void)showPHView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)showPHView:(BOOL)animal
{
    self.animalTime = 0.5;
    [self showPHView];
    if(self.isShow == NO)//未展示
    {
        //        NSLog(@"未展示");
        if(animal)//有动画的
        {
            CGRect rect1 = CGRectMake(0, 0, self.phTableView.frame.size.width, 0);
            CGRect rect2 = CGRectMake(0, 0, self.phTableView.frame.size.width, self.phTableView.frame.size.height);
            //
            self.phTableView.frame = rect1;
            [UIView animateWithDuration:self.animalTime animations:^{
                self.phTableView.frame = rect2;
            }];
        }
    }
    else//已展示
    {
        //        NSLog(@"已展示");
    }
    [self changeShowStatus:YES];
    
}
-(void)changeShowStatus:(BOOL)status
{
    self.isShow = status;
}
#pragma mark -- 消失方法
-(void)dismissPHView
{
    [self changeShowStatus:NO];
    self.backgroundButton.hidden = NO;
    [self removeFromSuperview];
}
-(void)dismissPHView:(BOOL)animal
{
    self.animalTime = 0.5;
    if(animal)//有动画
    {
        [NSTimer scheduledTimerWithTimeInterval:self.animalTime target:self selector:@selector(dismissPHView) userInfo:nil repeats:NO];
        self.backgroundButton.hidden = YES;
        CGRect rect1 = CGRectMake(0, 0, self.phTableView.frame.size.width, 0);
        CGRect rect2 = CGRectMake(0, 0, self.phTableView.frame.size.width, self.phTableView.frame.size.height);
        //
        self.phTableView.frame = rect2;
        [UIView animateWithDuration:self.animalTime animations:^{
            self.phTableView.frame = rect1;
        }];
    }
    else
    {
        [self dismissPHView];
    }
    
}
//没有默认值
-(void)showPHChooseListWithArray:(NSArray *)array withFrame:(CGRect)frame
{
    [self getDataArray:array];
    [self dealWithFrame:frame andArrayCount:array.count];
}
//有默认值
-(void)showPHChooseListWithArray:(NSArray *)array withFrame:(CGRect)frame andSelectString:(NSString *)selectString;
{
    //处理已经选中的字符串.
    [self flagHaveSelectString:selectString andArray:array];
    //
    [self showPHChooseListWithArray:array withFrame:frame];
}
//有默认数值的
-(void)showPHChooseListWithArray:(NSArray *)array withFrame:(CGRect)frame andSelectIndex:(NSInteger)selectIndex
{
    //处理已经选中的字符串.
    [self flagHaveSelectString:[array objectAtIndex:selectIndex] andArray:array];
    //
    [self showPHChooseListWithArray:array withFrame:frame];
}
#pragma mark -- UItableViewDelagate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellMark = @"PHDropDownChooseToolViewCell";
    PHDropDownChooseToolViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMark];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PHDropDownChooseToolViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    [cell pushCellBottomViewLineBackground:self.bottomColor];//设置底部颜色
    /*liuyao ui说不用设置颜色*/
    [cell pushCellBottomViewLineBackground:[UIColor clearColor]];
    [cell pushCellWithSting:self.dataSourceArray[indexPath.row]];//设置cell内容
    [cell.titleLabel setFont:self.titleLabelFont];//设置字体大小
    cell.titleLabel.adjustsFontSizeToFitWidth = YES;
    if(self.isHaveDefaultString==YES)//设置选中颜色
    {
        if(self.selectedIndex == indexPath.row)
        {
            cell.titleLabel.textColor = self.selectedTextColor;
        }
        else
        {
            cell.titleLabel.textColor = self.normalTextColor;
        }
    }
    else{
        cell.titleLabel.textColor = self.normalTextColor;
    }
    if(self.alignment == PHDropDownChooseTitleLabelAlignmentCenter)//设置对齐方式
    {
        cell.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    else if(self.alignment == PHDropDownChooseTitleLabelAlignmentRight)
    {
        cell.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        cell.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    //修改title左右边距
    [cell pushTitleLabelLeftSide:self.titleLabelLeftSide andRightSide:self.titleLabelRightSide];
    [cell pushBottomLineLeftSide:self.bottomLeftSide andRightSide:self.bottomRightSide];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cellClickAction:indexPath.row];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PHTABLEVIEW_CELLHEIGHT;
}
#pragma mark -- 遮罩层的设置
//设置遮罩的透明度(默认是1.0)
-(void)setMaskViewAlaph:(float)alpha
{
    self.backgroundButton.alpha = alpha;
    self.maskButtonAlpha = alpha;
}
//设置遮罩的背景色(默认是黑色)
-(void)setMaskViewBackgroundColor:(UIColor *)backgroundColor
{
    self.backgroundButton.backgroundColor = backgroundColor;
}
//设置动画时间
-(void)setAnimaltime:(float)animalTime
{
    self.animalTime = animalTime;
}
#pragma mark -- 去响应代理方法
-(void)cellClickAction:(NSInteger)index
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(phDropDownList:andClickIndex:)])
    {
        [self.delegate phDropDownList:self andClickIndex:index];
        [self dismissPHView:YES];
    }
}

#pragma mark -- 设置cell的属性
-(void)setCellTitleLabelSelectedTextColor:(UIColor *)selectedTextColor//文字选中颜色
{
    self.selectedTextColor = selectedTextColor;
}
-(void)setCellTitleLabelNormalTextColor:(UIColor *)normalColor//文字普通颜色
{
    self.normalTextColor = normalColor;
}
-(void)setCellTitleLabelAlignment:(PHDropDownChooseTitleLabelAlignment)alignment//设置文字的对齐方式
{
    self.alignment = alignment;
}
-(void)setCelltitleLabelFont:(UIFont *)textFont//文字的字体大小.
{
    self.titleLabelFont = textFont;
}
-(void)setCellBottomLineColor:(UIColor *)color//底部线的颜色
{
    self.bottomColor = color;
}
//修改title左右边距
-(void)setCellTitleLabelLeftSide:(float)leftSide
{
    self.titleLabelLeftSide = leftSide;
}
-(void)setCellTitleLabelRightSide:(float)rightSide
{
    self.titleLabelRightSide = rightSide;
}
-(void)setCellTitleLabelLeftSide:(float)leftSide andRightSide:(float)rightSide
{
    [self setCellTitleLabelLeftSide:leftSide];
    [self setCellTitleLabelLeftSide:leftSide];
}
//修改line左右边距
-(void)setCellBottomLineLeftSide:(float)leftSide
{
    self.bottomLeftSide = leftSide;
}
-(void)setCellBottomLineRightSide:(float)rightSide
{
    self.bottomRightSide = rightSide;
}
-(void)setCellBottomLineLeftSide:(float)leftSide andRightSide:(float)rightSide
{
    [self setCellBottomLineLeftSide:leftSide];
    [self setCellBottomLineRightSide:rightSide];
}
#pragma mark -- 工具类方法
-(UIButton *)getBackgroundButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blackColor];
    button.alpha = 0.5;
    self.maskButtonAlpha = 0.5;
    [button addTarget:self action:@selector(backgroundButtonDismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}
-(void)backgroundButtonDismiss
{
    [self dismissPHView:YES];
}
-(UITableView *)getTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:tableView];
    return tableView;
}
-(void)getDataArray:(NSArray *)array
{
    if([self.dataSourceArray count]!=0)
    {
        [self.dataSourceArray removeAllObjects];
    }
    self.dataSourceArray = [NSMutableArray arrayWithArray:array];
    [self.phTableView reloadData];
}

-(void)flagHaveSelectString:(NSString *)selectString andArray:(NSArray *)array
{
    self.isHaveDefaultString = NO;
    for(int i=0;i<array.count;i++)
    {
        NSString *stringTemp = [array objectAtIndex:i];
        if([selectString isEqualToString:stringTemp])
        {
            self.isHaveDefaultString = YES;
            self.selectedIndex = i;
            break;
        }
    }
    //得到的selectIndex去刷新整个页面.
}
-(void)dealWithFrame:(CGRect)frame  andArrayCount:(NSInteger)count
{
    [self setFrame:frame];
    [self.backgroundButton setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    //此处做个计算。如果table的数量太多的时候则ableView是可以滑动的
    CGRect tableViewFrame = CGRectMake(0, 0, frame.size.width, PHTABLEVIEW_CELLHEIGHT*count);
    if(PHTABLEVIEW_CELLHEIGHT*count>frame.size.height)//超出了页面(可滑动)
    {
        tableViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.phTableView.bounces = YES;
    }
    else//未超出页面(不可滑动)(有遮罩)
    {
        self.phTableView.bounces = NO;
    }
    [self.phTableView setFrame:tableViewFrame];
}

@end
