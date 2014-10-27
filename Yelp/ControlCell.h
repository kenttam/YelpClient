//
//  ControlCell.h
//  Yelp
//
//  Created by Kent Tam on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ControlCell;
@protocol ControlCellDelegate <NSObject>

- (void)controlCell:(ControlCell *)cell didUpdateValue:(BOOL)value;

@end
@interface ControlCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) id<ControlCellDelegate>delegate;
@property (nonatomic, assign)BOOL on;
- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
