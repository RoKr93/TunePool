//
//  PlaylistSession.h
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface PlaylistSession : NSObject

+ (PlaylistSession *)createPlaylistSessionWithOwner:(User *)owner name:(NSString *)name;

@end
