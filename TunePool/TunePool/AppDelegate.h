//
//  AppDelegate.h
//  TunePool
//
//  Created by Roshan Krishnan on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Spotify/Spotify.h>

#import "NavigationProtocol.h"
#import "LoginPageViewController.h"
#import "HomePageViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NavigationProtocol>

@property (strong, nonatomic) UIWindow *window;


@end

