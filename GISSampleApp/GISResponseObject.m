//
//  GISResponseObject.m
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import "GISResponseObject.h"
#import "NSDictionary+Validation.h"


@implementation GISResponseObject

+ (instancetype)objectWithDictionary:(NSDictionary *)dict
{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    GISResponseObject *object = [GISResponseObject new];
    
    object.resultClass          = [dict objectForKey:@"GsearchResultClass" expectedClass:[NSString class]];
    object.imageID              = [dict objectForKey:@"imageId" expectedClass:[NSString class]];
    
    object.title                = [dict objectForKey:@"title" expectedClass:[NSString class]];
    object.titleNoFormatting    = [dict objectForKey:@"titleNoFormatting" expectedClass:[NSString class]];
    object.content              = [dict objectForKey:@"content" expectedClass:[NSString class]];
    object.contentNoFormatting  = [dict objectForKey:@"contentNoFormatting" expectedClass:[NSString class]];
    object.contextURLString     = [dict objectForKey:@"originalContextUrl" expectedClass:[NSString class]];
    object.visibleURLString     = [dict objectForKey:@"visibleUrl" expectedClass:[NSString class]];
    
    object.thumbURLString       = [dict objectForKey:@"tbUrl" expectedClass:[NSString class]];
    object.thumbWidth           = [dict objectForKey:@"tbWidth" expectedClass:[NSString class]];
    object.thumbHeight          = [dict objectForKey:@"tbHeight" expectedClass:[NSString class]];
    
    object.URLString            = [dict objectForKey:@"url" expectedClass:[NSString class]];
    object.unescapedURLString   = [dict objectForKey:@"unescapedUrl" expectedClass:[NSString class]];
    object.width                = [dict objectForKey:@"width" expectedClass:[NSString class]];
    object.height               = [dict objectForKey:@"height" expectedClass:[NSString class]];

    return object;
}

+ (NSArray *)objectsWithArray:(NSArray *)array
{
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray *objects = [NSMutableArray new];
    for (NSDictionary *dict in array) {
        GISResponseObject *object = [GISResponseObject objectWithDictionary:dict];
        if (object) {
            [objects addObject:object];
        }
    }
    return [objects copy];
}

@end
