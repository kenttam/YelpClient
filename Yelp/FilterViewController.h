//
//  FilterViewController.h
//  Yelp
//
//  Created by Kent Tam on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FilterViewController *) filtersViewController didChangeFilters:(NSDictionary *)filters;
@end

@interface FilterViewController : UIViewController

@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
