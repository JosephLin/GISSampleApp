//
//  GISManager.h
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GISQueryObject;

typedef void(^GISAPISuccessBlock)(NSInteger total, NSInteger currentPage, NSArray *objects);
typedef void(^GISAPIFailureBlock)(NSError *error);

extern NSString * const GISErrorDomain;
typedef NS_ENUM(NSInteger, GISErrorCode) {
    GISErrorCodeInvalidRequest = 1001,
    GISErrorCodeInvalidResponse = 1002,
};


@interface GISAPIManager : NSObject

+ (instancetype)sharedInstance;

- (void)query:(GISQueryObject *)queryObject success:(GISAPISuccessBlock)success failure:(GISAPIFailureBlock)failure;

@end
