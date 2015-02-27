//
//  GISQueryObject.h
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GISQueryObject : NSObject

@property (nonatomic) NSString *query;

@property (nonatomic) NSString *version;
@property (nonatomic) NSString *asFileType;
@property (nonatomic) NSString *asRights;
@property (nonatomic) NSString *asSiteSearch;
@property (nonatomic) NSString *hostLanguage;
@property (nonatomic) NSString *imageColorization;
@property (nonatomic) NSString *imageColor;
@property (nonatomic) NSString *imageSize;
@property (nonatomic) NSString *imageType;
@property (nonatomic) NSString *safe;

@property (nonatomic) NSNumber *perPage;
@property (nonatomic) NSNumber *offset;
@property (nonatomic) NSNumber *maxOffset;

@property (nonatomic) NSString *userIP;

+ (instancetype)objectWithQuery:(NSString *)query;
- (NSDictionary *)JSONDictionary;

@end
