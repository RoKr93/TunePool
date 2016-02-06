//
//  PlaylistSessionManager.h
//  TunePool
//
//  Created by Evan Shenkman on 2/5/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Spotify/Spotify.h>
#import <CoreLocation/CoreLocation.h>
#import "User.h"
#import "PlaylistSession.h"

@interface PlaylistSessionManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic) NSMutableArray *availablePlaylistSessions;

- (id)initWithUser:(User *)user andSpotifySession:(SPTSession *)session;
- (BOOL)startLocationTracking;
- (BOOL)stopLocationTracking;
- (BOOL)getAvailableSessions;

- (void)createNewPlaylistSessionWithUser:(User *)user Name:(NSString *)name andLocation:(CLLocation *)location;
- (void)findLocalPlaylistsForLocation:(CLLocation *)location;
- (void)joinLocalPlaylist:(PlaylistSession *)playlistSession;

@end
