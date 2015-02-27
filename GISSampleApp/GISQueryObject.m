//
//  GISQueryObject.m
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import "GISQueryObject.h"


@implementation GISQueryObject

+ (NSDictionary *)keyMapper
{
    static NSDictionary *_keyMapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keyMapper = @{
                       @"query"             : @"q",
                       @"version"           : @"v",
                       @"asFileType"        : @"as_filetype",
                       @"asRights"          : @"as_rights",
                       @"asSiteSearch"      : @"as_sitesearch",
                       @"hostLanguage"      : @"hl",
                       @"imageColorization" : @"imgc",
                       @"imageColor"        : @"imgcolor",
                       @"imageSize"         : @"imgsz",
                       @"imageType"         : @"imgtype",
                       @"safe"              : @"safe",
                       @"perPage"           : @"rsz",
                       @"offset"            : @"start",
                       @"userIP"            : @"userip",
                       };
    });
    return _keyMapper;
}

- (NSDictionary *)JSONDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary new];

    [[GISQueryObject keyMapper] enumerateKeysAndObjectsUsingBlock:^(id key, id serverKey, BOOL *stop) {
        id value = [self valueForKey:key];
        if (value) {
            dict[serverKey] = value;
        }
    }];
    return dict;
}

+ (instancetype)defaultObject
{
    GISQueryObject *object = [self new];
    object.version = @"1.0";
    object.perPage = @"8";
    return object;
}

+ (instancetype)objectWithQuery:(NSString *)query
{
    GISQueryObject *object = [self defaultObject];
    object.query = query;
    return object;
}

@end
