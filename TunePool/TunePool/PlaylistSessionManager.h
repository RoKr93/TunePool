//
//  PlaylistSessionManager.h
//  TunePool
//
//  Created by Evan Shenkman on 2/5/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>
#import "User.h"
#import "PlaylistSession.h"

@interface PlaylistSessionManager : NSObject <CLLocationManagerDelegate>

- (id)init;

- (BOOL)startLocationTracking;
- (BOOL)stopLocationTracking;

- (void)createNewPlaylistSessionWithUser:(User *)user Name:(NSString *)name andLocation:(CLLocation *)location;
- (void)findLocalPlaylistsForLocation:(CLLocation *)location;
- (void)joinLocalPlaylist:(PlaylistSession *)playlistSession;

@end
