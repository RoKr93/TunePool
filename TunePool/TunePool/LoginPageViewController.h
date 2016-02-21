//
//  LoginPageViewController.h
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginModel.h"
#import "NavigationProtocol.h"

@interface LoginPageViewController : UIViewController <LoginModelDelegate>

- (id)initWithAppDelegate:(id)appDelegate;

- (BOOL) application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation;

@end
