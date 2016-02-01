//
//  Artist.m
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "Artist.h"

@interface Artist ()

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *artistID;

@property (nonatomic) NSMutableArray *allAlbums;
@property (nonatomic) NSMutableArray *allSongs;

- (id)init;

@end

@implementation Artist

- (id)init
{
    self = [super init];
    return self;
}

+ (Artist*)createArtistWithResponse:(NSDictionary *)res
{
    Artist *newArtist = [[Artist alloc] init];
    
    //Extract the contents of the JSON Response
    
    return newArtist;
}

@end
