//
//  LoginModel.h
//  TunePool
//
//  Created by Roshan Krishnan on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Spotify/Spotify.h>
#import <Foundation/Foundation.h>

#import "User.h"

@protocol LoginModelDelegate <NSObject>
@required

- (void)loginModelSuccessWithUser:(User *)user andSpotifySession:(SPTSession *)session;
- (void)loginModelFailure;

@end

@interface LoginModel : NSObject

@property (nonatomic, strong) SPTSession *session;
@property (nonatomic, strong) NSMutableArray *scopes;

- (void)setDelegate:(id <LoginModelDelegate>)delegate;

- (BOOL) doLogin;
- (BOOL) application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation;
- (NSDictionary *) getUserInformation;

@end
