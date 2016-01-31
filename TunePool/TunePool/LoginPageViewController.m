//
//  LoginPageViewController.m
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "LoginPageViewController.h"

@interface LoginPageViewController ()

@property (nonatomic) UIAlertController *failAlert;

- (IBAction)loginButtonPressed:(id)sender;

@end

@implementation LoginPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    [self presentViewController:self.failAlert animated:true completion:nil];
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
