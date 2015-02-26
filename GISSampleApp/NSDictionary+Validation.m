//
//  NSDictionary+Validation.m
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import "NSDictionary+Validation.h"

@implementation NSDictionary (Validation)

- (id)objectForKey:(id)aKey expectedClass:(Class)expectedClass
{
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:expectedClass]) {
        return object;
    }
    return nil;
}

@end
