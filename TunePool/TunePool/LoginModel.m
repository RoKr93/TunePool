//
//  LoginModel.m
//  TunePool
//
//  Created by Roshan Krishnan on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

- (BOOL) doLogin {
    [[SPTAuth defaultInstance] setClientID:@"bd1f8ce3ea8146b2abe64fa1e134adbf"];
    [[SPTAuth defaultInstance] setRedirectURL:[NSURL URLWithString:@"tunepool://returnafterlogin"]];
    [[SPTAuth defaultInstance] setRequestedScopes:@[SPTAuthStreamingScope]];
    
    // Construct a login URL and open it
    NSURL *loginURL = [[SPTAuth defaultInstance] loginURL];
    
    // Opening a URL in Safari close to application launch may trigger
    // an iOS bug, so we wait a bit before doing so.
    [[UIApplication sharedApplication] performSelector:@selector(openURL:)
                                            withObject:loginURL afterDelay:0.1];
    
    return YES;
}

- (BOOL) application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation {
    
    // Ask SPTAuth if the URL given is a Spotify authentication callback
    if ([[SPTAuth defaultInstance] canHandleURL:url]) {
        [[SPTAuth defaultInstance] handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            
            if (error != nil) {
                NSLog(@"*** Auth error: %@", error);
                return;
            }
        }];
        return YES;
    }
    
    return NO;
}

@end
