//
//  NavigationProtocol.h
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#ifndef NavigationProtocol_h
#define NavigationProtocol_h

#import <Spotify/Spotify.h>
#import "User.h"

@protocol NavigationProtocol <NSObject>
@required
- (void)loginPageFinishedWithUser:(User *)user andSpotifySession:(SPTSession *)session;

@end


#endif /* NavigationProtocol_h */
