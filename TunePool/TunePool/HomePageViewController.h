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
#import "PlaylistSessionManager.h"


@interface HomePageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *availableSessions;
@property (strong, nonatomic) IBOutlet UIButton *createSessionButton;

- (id)initWithUser:(User *)user andSpotifySession:(SPTSession *)session andAppDelegate:(id)appDelegate;
- (IBAction)createSessionButtonPressed:(id)sender;

@end
