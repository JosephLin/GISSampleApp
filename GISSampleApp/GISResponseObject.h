//
//  GISResponseObject.h
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISResponseObject : NSObject

@property (nonatomic) NSString *resultClass;
@property (nonatomic) NSString *imageID;

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *titleNoFormatting;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *contentNoFormatting;
@property (nonatomic) NSString *contextURLString;
@property (nonatomic) NSString *visibleURLString;

@property (nonatomic) NSString *thumbURLString;
@property (nonatomic) NSString *thumbWidth;
@property (nonatomic) NSString *thumbHeight;

@property (nonatomic) NSString *URLString;
@property (nonatomic) NSString *unescapedURLString;
@property (nonatomic) NSString *width;
@property (nonatomic) NSString *height;

+ (instancetype)objectWithDictionary:(NSDictionary *)dict;
+ (NSArray *)objectsWithArray:(NSArray *)array;

@end
