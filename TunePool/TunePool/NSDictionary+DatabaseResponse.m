//
//  NSDictionary+DatabaseResponse.m
//  TunePool
//
//  Created by Evan Shenkman on 3/4/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "NSDictionary+DatabaseResponse.h"

@implementation NSDictionary (DatabaseResponse)

- (BOOL)databaseSuccessful
{
    return [[self objectForKey:@"response"] isEqualToString:@"success"];
}

@end
