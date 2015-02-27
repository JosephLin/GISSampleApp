//
//  UIImage+Placeholder.h
//  GISSampleApp
//
//  Created by Joseph Lin on 2/27/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Placeholder)

/**
 *  Create a placeholder image with the given icon in the center and padded to the given size.
 *
 *  @param imageName Name of the icon to put in the center.
 *  @param size      Size of the returned image.
 *
 *  @return An UIImage of the given size. If the size is smaller than the size of the icon image, the icon image is returned.
 */
+ (instancetype)placeholderImageNamed:(NSString *)imageName size:(CGSize)size;

@end
