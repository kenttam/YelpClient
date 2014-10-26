//
//  YelpTableViewCell.m
//  Yelp
//
//  Created by Kent Tam on 10/25/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpTableViewCell.h"
#import "Business.h"
#import "UIImageView+AFNetworking.h"

@interface YelpTableViewCell ()
- (void) setBusiness:(Business *)business;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *numReviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *addresLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@end
@implementation YelpTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
    self.thumbImageView.layer.cornerRadius = 3;
    self.thumbImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBusiness:(Business *)business{
    _business = business;
    NSString *imageURL = self.business.imageUrl;
    [self.thumbImageView setImageWithURL:[NSURL URLWithString:imageURL]];
    self.nameLabel.text = self.business.name;
    [self.ratingImageView setImageWithURL:[NSURL URLWithString: self.business.ratingImageUrl]];
    self.numReviewLabel.text = [NSString stringWithFormat:@"%ld Reviews", (long)self.business.numReviews];
    self.addresLabel.text = self.business.address;
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi", self.business.distance];
    
}

- (float)meterToMiles:(float)meter {
    return meter * 0.000621371;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
}

@end
