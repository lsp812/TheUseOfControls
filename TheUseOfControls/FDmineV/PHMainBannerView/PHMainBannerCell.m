//
//  PHMainBannerCell.m
//  iMSBuyerTicket
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 Martin Hartl. All rights reserved.
//

#import "PHMainBannerCell.h"

@interface PHMainBannerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;

@end

@implementation PHMainBannerCell

-(void)awakeFromNib {
    
}

- (void)pushBannerData:(NSDictionary *)dic
{
    [self.projectImageView setImage:[dic valueForKey:@"image"]];
    self.projectNameLabel.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"title"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
