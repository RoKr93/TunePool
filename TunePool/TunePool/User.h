//
//  User.h
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Spotify/Spotify.h>
#import <Foundation/Foundation.h>

#import "SerializeProtocol.h"

@interface User : NSObject <SerializeProtocol>

+ (User*)createUserWithSPTUser:(SPTUser *)user;

+ (NSDictionary *)serializeObjectToDictionary:(id)pObj;

@end
