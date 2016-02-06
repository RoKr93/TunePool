//
//  PlaylistSessionManager.m
//  TunePool
//
//  Created by Evan Shenkman on 2/5/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "PlaylistSessionManager.h"

@interface PlaylistSessionManager ()

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) User *user;
@property (nonatomic) SPTSession *session;

- (void)setupCL;

@end

@implementation PlaylistSessionManager

- (id)initWithUser:(User *)user andSpotifySession:(SPTSession *)session
{
    self = [super init];
    if (self)
    {
        self.user = user;
        self.session = session;
        [self setupCL];
    }
    return self;
}

- (void)setupCL
{
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    [self.locationManager setDistanceFilter:2000];
}

- (BOOL)startLocationTracking
{
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation];
        return true;
    }
    
    return false;
}

- (BOOL)stopLocationTracking
{
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager stopUpdatingLocation];
        return true;
    }
    
    return false;
}

- (void)createNewPlaylistSessionWithUser:(User *)user Name:(NSString *)name andLocation:(CLLocation *)location
{
    //This is going to be a database call....
    
}

- (void)findLocalPlaylistsForLocation:(CLLocation *)location
{
    //Also a database call....
    
}

- (void)joinLocalPlaylist:(PlaylistSession *)playlistSession
{
    //Yet another database call....
}

#pragma mark - Location Manager Protocol Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    if (fabs(howRecent) < 15)
    {
        // If the event is recent, do something with it
        // TODO: push info to web server
        NSLog(@"latitude %+.6f, longitude %+.6f\n", location.coordinate.latitude, location.coordinate.longitude);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

@end
