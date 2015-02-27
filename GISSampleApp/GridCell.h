//
//  GridCell.h
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GISResponseObject;


@interface GridCell : UICollectionViewCell

@property (nonatomic, strong) GISResponseObject *responseObject;

@end
