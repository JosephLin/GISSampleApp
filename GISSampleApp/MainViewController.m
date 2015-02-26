//
//  ViewController.m
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "GISManager.h"
#import "GISResponseObject.h"
#import "GridCell.h"
#import "EXTScope.h"


@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic)       NSMutableArray *responseObjects;
@end


@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.responseObjects = [NSMutableArray new];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *text = searchBar.text;
    
    @weakify(self);
    [[GISManager sharedInstance] query:text completion:^(BOOL success, NSArray *objects, NSError *error) {
        @strongify(self);

        if (!success) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }

        [self.responseObjects addObjectsFromArray:objects];
        [self.collectionView reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.responseObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GISResponseObject *object = self.responseObjects[indexPath.row];
    NSParameterAssert([object isKindOfClass:[GISResponseObject class]]);

    GridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GridCell class]) forIndexPath:indexPath];
    cell.object = object;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    GISResponseObject *object = self.responseObjects[indexPath.row];
    NSParameterAssert([object isKindOfClass:[GISResponseObject class]]);

    [self performSegueWithIdentifier:@"DetailSegue" sender:object];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *controller = segue.destinationViewController;
    NSParameterAssert([controller isKindOfClass:[DetailViewController class]]);
    
    controller.object = sender;
}

@end
