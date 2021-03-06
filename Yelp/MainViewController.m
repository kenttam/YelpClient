//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "YelpTableViewCell.h"
#import "Business.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate>

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) YelpTableViewCell *prototypeYelpTableViewCell;
-(void) fetchBusinessesWithQuery:(NSString *)query params:(NSDictionary *) params;

@end

@implementation MainViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        self.title = @"Yelp";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"YelpTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"YelpTableViewCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.text = @"Restaurant";
    self.navigationItem.titleView = self.searchBar;
    [self fetchBusinessesWithQuery:self.searchBar.text params:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (YelpTableViewCell *)prototypeYelpTableViewCell {
    if (_prototypeYelpTableViewCell == nil) {
        _prototypeYelpTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"YelpTableViewCell"];
    }
    
    return _prototypeYelpTableViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.prototypeYelpTableViewCell.business = self.businesses[indexPath.row];
    CGSize size = [self.prototypeYelpTableViewCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.businesses.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpTableViewCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

#pragma mark - Filter delegate methods

- (void)filtersViewController:(FilterViewController *)filtersViewController didChangeFilters:(NSDictionary *)filters{
    [self fetchBusinessesWithQuery:self.searchBar.text params:filters];
}

#pragma mark - Private methods

- (void)onFilterButton{
    FilterViewController *vc = [[FilterViewController alloc]init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)fetchBusinessesWithQuery:(NSString *)query params:(NSDictionary *)params{
    [self.client searchWithTerm:query params:params success:^(AFHTTPRequestOperation *operation, id response) {
        self.businesses = [Business businessesWithDictionaries:response[@"businesses"]];
        NSLog(@"%@", self.businesses);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

@end
