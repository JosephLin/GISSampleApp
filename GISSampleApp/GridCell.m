//
//  GridCell.m
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import "GridCell.h"
#import "GISResponseObject.h"
#import "UIImageView+AFNetworking.h"


@interface GridCell ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end


@implementation GridCell

- (void)setResponseObject:(GISResponseObject *)responseObject
{
    _responseObject = responseObject;
    if (responseObject.thumbURLString) {
        NSURL *URL = [NSURL URLWithString:responseObject.thumbURLString];
        [self.imageView setImageWithURL:URL];
    }
    else {
        [self.imageView cancelImageRequestOperation];
        self.imageView.image = nil;
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.imageView cancelImageRequestOperation];
    self.imageView.image = nil;
}

@end
