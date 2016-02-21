//
//  LoginPageViewController.m
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "LoginPageViewController.h"

@interface LoginPageViewController ()

@property (nonatomic) id appDelegate;

@property (nonatomic) UIAlertController *failAlert;
@property (nonatomic) LoginModel *loginModel;

- (IBAction)loginButtonPressed:(id)sender;

@end

@implementation LoginPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.loginModel = [[LoginModel alloc] init];
    [self.loginModel setDelegate:self];
    
    self.failAlert = [UIAlertController alertControllerWithTitle:@"N00B!" message:@"You couldn't login because you're probably a dumb noob." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Sorry, dad..." style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"FUCK YOU DAD! NO RULES! 2016!");
    }];
    
    [self.failAlert addAction:defaultAction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender
{
    //something something Spotify SDK
    if(![self.loginModel doLogin])
        [self presentViewController:self.failAlert animated:true completion:nil];
}

- (BOOL) application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation {
    [self.loginModel application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return YES;
}


#pragma mark - LoginModel Delegate Methods

- (void)loginModelSuccessWithUser:(User *)user andSpotifySession:(SPTSession *)session
{
    NSLog(@"LoginModel says WOOP WOOP swag!");
    
    if([(NSObject*)self.appDelegate respondsToSelector:@selector(loginPageFinishedWithUser:andSpotifySession:)])
    {
        [self.appDelegate loginPageFinishedWithUser:user andSpotifySession:session];
    }
}

- (void)loginModelFailure
{
    NSLog(@"LoginModel says fuk");
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
