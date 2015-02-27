//
//  ViewController.m
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "GISAPIManager.h"
#import "GISQueryObject.h"
#import "GISResponseObject.h"
#import "GridCell.h"
#import "EXTScope.h"

static NSUInteger const kNumberOfColumns = 3;


@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic)       NSMutableArray *responseObjects;
@property (nonatomic)       NSMutableArray *queryHistory;
@property (nonatomic)       GISQueryObject *currentQueryObject;
@property (nonatomic)       NSInteger numberOfObjectsToLoad;
@end


@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.responseObjects = [NSMutableArray new];
    self.queryHistory = [NSMutableArray new];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateCollectionViewLayout];
}


#pragma mark - Setter

- (void)setCurrentQueryObject:(GISQueryObject *)currentQueryObject
{
    if (_currentQueryObject) {
        [self.queryHistory addObject:_currentQueryObject.query];
    }
    
    _currentQueryObject = currentQueryObject;
    
    [self.responseObjects removeAllObjects];
    [self.collectionView reloadData];
    [self checkNumberOfObjectsToLoad];
}


#pragma mark - Search

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchButtonTapped:nil];
}

- (IBAction)searchButtonTapped:(id)sender
{
    [self hideTableView];
    [self.searchBar resignFirstResponder];
    NSString *text = self.searchBar.text;
    self.currentQueryObject = [GISQueryObject objectWithQuery:text];
    [self performSearch];
}

- (void)performSearchIfNeeded
{
    NSInteger numberOfLoadedItems = self.responseObjects.count;
    if (numberOfLoadedItems < self.numberOfObjectsToLoad) {

        NSInteger currentOffset = self.currentQueryObject.offset.integerValue;
        if (currentOffset < numberOfLoadedItems) {
            self.currentQueryObject.offset = [NSString stringWithFormat:@"%lu", (unsigned long)numberOfLoadedItems];
            [self performSearch];
        }
    }
}

- (void)performSearch
{
    @weakify(self);
    [[GISAPIManager sharedInstance] query:self.currentQueryObject success:^(NSInteger total, NSInteger currentPage, NSArray *objects) {
        @strongify(self);
        
        [self.responseObjects addObjectsFromArray:objects];
        [self.collectionView reloadData];
        [self performSearchIfNeeded];
    } failure:^(NSError *error) {
        @strongify(self);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}


#pragma mark - Scrolling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self checkNumberOfObjectsToLoad];
}

- (void)checkNumberOfObjectsToLoad
{
    UICollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    
    CGFloat maxY = self.collectionView.contentOffset.y + CGRectGetHeight(self.collectionView.frame);
    NSUInteger numberOfRowsNeeded = (maxY - layout.sectionInset.top) / (layout.itemSize.height + layout.minimumLineSpacing);
    NSUInteger numberOfObjectsNeeded = numberOfRowsNeeded * kNumberOfColumns + 1;
    
    if (self.numberOfObjectsToLoad < numberOfObjectsNeeded) {
        self.numberOfObjectsToLoad = numberOfObjectsNeeded;
        [self performSearchIfNeeded];
    }
}


#pragma mark - Collection View

- (void)updateCollectionViewLayout
{
    UICollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    NSParameterAssert([layout isKindOfClass:[UICollectionViewFlowLayout class]]);
    
    CGFloat viewWidth = CGRectGetWidth(self.collectionView.frame);
    CGFloat size = (viewWidth - layout.sectionInset.left - layout.sectionInset.right - (kNumberOfColumns - 1) * layout.minimumInteritemSpacing) / kNumberOfColumns;
    layout.itemSize = CGSizeMake(size, size);

    self.collectionView.collectionViewLayout = layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.responseObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GISResponseObject *responseObject = self.responseObjects[indexPath.row];
    NSParameterAssert([responseObject isKindOfClass:[GISResponseObject class]]);

    GridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GridCell class]) forIndexPath:indexPath];
    cell.responseObject = responseObject;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    GISResponseObject *responseObject = self.responseObjects[indexPath.row];
    NSParameterAssert([responseObject isKindOfClass:[GISResponseObject class]]);

    [self performSegueWithIdentifier:@"DetailSegue" sender:responseObject];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *controller = segue.destinationViewController;
    NSParameterAssert([controller isKindOfClass:[DetailViewController class]]);
    
    controller.responseObject = sender;
}


#pragma mark - Bookmark

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    if (!self.tableView) {
        [self showTableView];
    }
    else {
        [self hideTableView];
    }
}

- (void)showTableView
{
    if (!self.tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.collectionView.frame style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
}

- (void)hideTableView
{
    if (self.tableView) {
        [self.tableView removeFromSuperview];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.queryHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *query = self.queryHistory[self.queryHistory.count - indexPath.row - 1];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = query;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *query = self.queryHistory[self.queryHistory.count - indexPath.row - 1];
    self.searchBar.text = query;
    [self searchButtonTapped:nil];
}

@end
