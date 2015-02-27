//
//  UIImage+Placeholder.m
//  GISSampleApp
//
//  Created by Joseph Lin on 2/27/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import "UIImage+Placeholder.h"


@implementation UIImage (Placeholder)

+ (NSCache *)placeholderCache
{
    static NSCache *_placeholderCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _placeholderCache = [NSCache new];
    });
    return _placeholderCache;
}

+ (instancetype)placeholderImageNamed:(NSString *)imageName size:(CGSize)size
{
    id key = [NSValue valueWithCGSize:size];
    
    UIImage *cachedImage = [[self placeholderCache] objectForKey:key];
    if (cachedImage) {
        return cachedImage;
    }

    
    UIImage *image = [UIImage imageNamed:imageName];
    CGSize imageSize = image.size;
    if (size.width < imageSize.width || size.height < imageSize.height) {
        [[self placeholderCache] setObject:image forKey:key];
        return image;
    }
    
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0.25 alpha:1.0] setFill];
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGRect rect = CGRectMake(0.5 * (size.width - imageSize.width), 0.5 * (size.height - imageSize.height), imageSize.width, imageSize.height);
    [image drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[self placeholderCache] setObject:newImage forKey:key];

    return newImage;
}

@end
