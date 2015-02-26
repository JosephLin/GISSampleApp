//
//  GISManager.m
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import "GISManager.h"
#import "AFNetworking.h"
#import "GISResponseObject.h"

NSString * const GISErrorDomain = @"GISErrorDomain";
static NSString * const GISBaseURLString = @"http://ajax.googleapis.com";
static NSString * const GISBasePath = @"ajax/services/search/images";


//ajax.googleapis.com/ajax/services/search/images?v=1.0&q=fuzzy%20monkey


@interface GISManager ()
@property (nonatomic) AFHTTPRequestOperationManager *requestManager;
@end


@implementation GISManager

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self new];
    });
    return _sharedInstance;
}

- (AFHTTPRequestOperationManager *)requestManager
{
    if (!_requestManager) {
        _requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:GISBaseURLString]];
    }
    return _requestManager;
}

- (void)query:(NSString *)query completion:(GISCompletionBlock)completion
{
    if (!query) {
        NSError *error = [NSError errorWithDomain:GISErrorDomain code:GISErrorCodeInvalidRequest userInfo:@{NSLocalizedDescriptionKey:@"Empty query"}];
        if (completion) completion(NO, nil, error);
        return;
    }
    
    NSDictionary *params = @{
                             @"q" : query,
                             @"v" : @"1.0",
                             };
    
    
    [self.requestManager GET:GISBasePath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        /*
         {
         "responseData" : {
         "results" : [],
         "cursor" : {}
         },
         "responseDetails" : null | string-on-error,
         "responseStatus" : 200 | error-code
         }
         */

        NSNumber *responseStatus = responseObject[@"responseStatus"];
        if (responseStatus.integerValue == 200) {
            NSDictionary *responseData = responseObject[@"responseData"];
            NSArray *results = responseData[@"results"];
            NSDictionary *cursor = responseData[@"cursor"];
            
            NSArray *objects = [GISResponseObject objectsWithArray:results];
            if (completion) completion(YES, objects, nil);
        }
        else {
            NSString *responseDetails = responseObject[@"responseDetails"];
            NSString *description = responseDetails ?: @"Unknown error";
            NSError *error = [NSError errorWithDomain:GISErrorDomain code:GISErrorCodeInvalidResponse userInfo:@{NSLocalizedDescriptionKey:description}];
            if (completion) completion(NO, nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) completion(NO, nil, error);
    }];
}

@end


















