//
//  ControlCell.m
//  Yelp
//
//  Created by Kent Tam on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ControlCell.h"

@interface ControlCell ()
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
- (IBAction)switchValueChanged:(id)sender;

@end
@implementation ControlCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchValueChanged:(id)sender {
    [self.delegate controlCell:self didUpdateValue:self.toggleSwitch.on];
}

- (void)setOn:(BOOL)on{
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.toggleSwitch setOn:on animated:animated];
}

@end
