//
//  DetailViewController.h
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GISResponseObject;


@interface DetailViewController : UIViewController

@property (nonatomic, strong) GISResponseObject *object;

@end
