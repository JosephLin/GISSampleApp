//
//  NSDictionary+Validation.h
//  GISSampleApp
//
//  Created by Joseph Lin on 2/25/15.
//  Copyright (c) 2015 Joseph Lin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (Validation)

/**
 *  Returns nil if the object is not a kind of the expectedClass.
 */
- (id)objectForKey:(id)aKey expectedClass:(Class)expectedClass;

@end
