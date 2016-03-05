//
//  LoginModel.m
//  TunePool
//
//  Created by Roshan Krishnan on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "LoginModel.h"

@interface LoginModel ()

@property (weak, nonatomic) id <LoginModelDelegate> delegate;

@end

@implementation LoginModel

- (id) init
{
    self = [super init];
    if(self)
    {
        // we want to be able to stream and access user information
        self.scopes = [[NSMutableArray alloc] init];
        [self.scopes addObject:SPTAuthStreamingScope];
        [self.scopes addObject:SPTAuthUserReadPrivateScope];
    }
    return self;
}

//- (void)setDelegate:(id<LoginModelDelegate>)delegate
//{
//    self.delegate = delegate;
//}

- (BOOL) doLogin
{
    [[SPTAuth defaultInstance] setClientID:@"bd1f8ce3ea8146b2abe64fa1e134adbf"];
    [[SPTAuth defaultInstance] setRedirectURL:[NSURL URLWithString:@"tunepool://returnafterlogin"]];
    [[SPTAuth defaultInstance] setRequestedScopes:self.scopes];
    
    // Construct a login URL and open it
    NSURL *loginURL = [[SPTAuth defaultInstance] loginURL];
    
    // Opening a URL in Safari close to application launch may trigger
    // an iOS bug, so we wait a bit before doing so.
    [[UIApplication sharedApplication] performSelector:@selector(openURL:)
                                            withObject:loginURL afterDelay:0.1];
    
    return YES;
}

- (void) application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation {
    
    // Ask SPTAuth if the URL given is a Spotify authentication callback
    if ([[SPTAuth defaultInstance] canHandleURL:url])
    {
        [[SPTAuth defaultInstance] handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            
            // check for error
            if (error != nil)
            {
                NSLog(@"*** Auth error: %@", error);
                // notify the viewcontroller that we failed
                if([(NSObject *)self.delegate respondsToSelector:@selector(loginModelFailure)])
                {
                    [self.delegate loginModelFailure];
                }
                return;
            }
            
            // store the session in our property
            self.session = session;
            
            // check if we have a session
            if(self.session != nil)
            {
                self.user = [self getUserInformation];
                
                [[DatabaseTalker getDatabaseTalker] loginAsUser:self.user andCompletionBlock:^(NSDictionary *response)
                {
                    if ([response databaseSuccessful])
                    {
                        // we succeeded, aw yuhhh
                        if([(NSObject *)self.delegate respondsToSelector:@selector(loginModelSuccessWithUser:andSpotifySession:)])
                        {
                            [self.delegate loginModelSuccessWithUser:[self getUserInformation] andSpotifySession:self.session];
                        }
                    }
                    else
                    {
                        // can't handle the URL, so we failed
                        if([(NSObject *)self.delegate respondsToSelector:@selector(loginModelFailure)])
                        {
                            [self.delegate loginModelFailure];
                        }
                    }
                }];
               
            }
            else
            {
                // can't handle the URL, so we failed
                if([(NSObject *)self.delegate respondsToSelector:@selector(loginModelFailure)])
                {
                    [self.delegate loginModelFailure];
                }
            }
        }];
    }
}

- (User *) getUserInformation
{
    __block User *myUser = nil;
    
    [SPTUser requestCurrentUserWithAccessToken:self.session.accessToken callback:^(NSError *error, SPTUser *user)
    {
        // check for error
        if (error != nil)
        {
            NSLog(@"*** Auth error: %@", error);
            // notify the viewcontroller that we failed
            if([(NSObject *)self.delegate respondsToSelector:@selector(loginModelFailure)])
            {
                [self.delegate loginModelFailure];
            }
            return;
        }
        myUser = [User createUserWithSPTUser:user];
    
    }];
    
    return myUser;
}

@end
