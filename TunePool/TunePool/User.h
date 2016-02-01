//
//  User.h
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Spotify/Spotify.h>
#import <Foundation/Foundation.h>

@interface User : NSObject

+ (User*)createUserWithSPTUser:(SPTUser *)user;

@end
