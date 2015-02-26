//
//  GISManager.h
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const GISErrorDomain;
typedef void(^GISCompletionBlock)(BOOL success, NSArray *objects, NSError *error);

typedef NS_ENUM(NSInteger, GISErrorCode) {
    GISErrorCodeInvalidRequest = 1001,
    GISErrorCodeInvalidResponse = 1002,
};


@interface GISManager : NSObject

+ (instancetype)sharedInstance;

- (void)query:(NSString *)query completion:(GISCompletionBlock)completion;

@end
