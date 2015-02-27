//
//  DetailViewController.m
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import "DetailViewController.h"
#import "GISResponseObject.h"
#import "UIImageView+AFNetworking.h"


@interface DetailViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@end


@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self reloadUI];
}

- (void)reloadUI
{
    if (self.responseObject.URLString) {
        NSURL *URL = [NSURL URLWithString:self.responseObject.URLString];
        [self.imageView setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    else {
        [self.imageView cancelImageRequestOperation];
        self.imageView.image = nil;
    }
    
    self.title = self.responseObject.titleNoFormatting;
    self.textLabel.text = self.responseObject.contentNoFormatting;
}

@end
