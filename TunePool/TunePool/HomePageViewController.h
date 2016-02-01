//
//  HomePageViewController.h
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Spotify/Spotify.h>
#import "User.h"


@interface HomePageViewController : UIViewController

- (id)initWithUser:(User *)user andSpotifySession:(SPTSession *)session;

@end
