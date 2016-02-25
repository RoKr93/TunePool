//
//  HomePageViewController.m
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@property (nonatomic) User *user;
@property (nonatomic) SPTSession *session;
@property (nonatomic) PlaylistSessionManager *playlistSessionManager;
@property (nonatomic) id appDelegate;

@end

@implementation HomePageViewController

- (id)initWithUser:(User *)user andSpotifySession:(SPTSession *)session andAppDelegate:(id)appDelegate
{
    self = [super init];
    if (self)
    {
        self.user = user;
        self.session = session;
        self.appDelegate = appDelegate;
        self.playlistSessionManager = [[PlaylistSessionManager alloc] initWithUser:self.user andSpotifySession:self.session];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.playlistSessionManager startLocationTracking];
    [self.playlistSessionManager getAvailableSessions];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.playlistSessionManager stopLocationTracking];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createSessionButtonPressed:(id)sender
{
    // TODO: create a new playlist session- we probably want to go to a new view for this
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Create New Playlist" message:@"Enter the information for this Playlist" preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
    {
        textField.placeholder = @"Playlist Name";
    }];
    
    UIAlertAction *create = [UIAlertAction actionWithTitle:@"Create Playlist" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        //Database Talker
        NSLog(@"Creating a Playlist with name - %@", [ac textFields][0].text);
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [ac addAction:create];
    [ac addAction:cancel];
    
    [self presentViewController:ac animated:true completion:nil];
}

#pragma mark - Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.playlistSessionManager.availablePlaylistSessions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.playlistSessionManager.availablePlaylistSessions objectAtIndex:indexPath.row];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
