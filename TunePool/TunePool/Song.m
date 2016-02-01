//
//  Song.m
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "Song.h"

@interface Song ()

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *artistName;
@property (nonatomic) NSString *albumName;
@property (nonatomic) NSDate *date;

//other shit

- (id)init;

@end

@implementation Song

- (id)init
{
    self = [super init];
    return self;
}

+ (Song*)createSongWithResponse:(NSDictionary *)res
{
    Song *newSong = [[Song alloc] init];
    
    //Extract the contents from the JSON Response
    
    return newSong;
}

@end
