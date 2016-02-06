//
//  PlaylistSessionManager.h
//  TunePool
//
//  Created by Evan Shenkman on 2/5/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface PlaylistSessionManager : NSObject <CLLocationManagerDelegate>

- (id)init;

- (BOOL)startLocationTracking;
- (BOOL)stopLocationTracking;

@end
