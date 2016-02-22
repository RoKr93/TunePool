//
//  DatabaseTalker.h
//  TunePool
//
//  Created by Evan Shenkman on 2/6/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

#import <CoreLocation/CoreLocation.h>
#import "User.h"
#import "PlaylistSession.h"

typedef void (^CompletionBlock)(id response);

@interface DatabaseTalker : NSObject

+ (DatabaseTalker *)getDatabaseTalker;
+ (DatabaseTalker *)getDatabaseTalkerForServer:(NSString *)server andPath:(NSString *)path andUser:(NSString *)user andPassword:(NSString *)pass;

- (void)testConnectionWithCompletion;

#pragma mark - General User Functions

- (void)loginAsUser:(User *)user andCompletionBlock:(CompletionBlock)completionBlock;

# pragma mark - Creating/Finding/Joining Playlist Sessions

- (void)createPlaylistSessionWithUser:(User *)user Name:(NSString *)name Location:(CLLocation *)location andCompletionBlock:(CompletionBlock)completionBlock;

- (void)findLocalPlaylistsForLocation:(CLLocation *)location;

- (void)joinLocalPlaylist:(PlaylistSession *)playlistSession;

@end
