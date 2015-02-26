//
//  GridCell.h
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GISResponseObject.h"


@interface GridCell : UICollectionViewCell

@property (nonatomic, strong) GISResponseObject *object;

@end
