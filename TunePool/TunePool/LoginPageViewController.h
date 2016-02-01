//
//  LoginPageViewController.h
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginModel.h"

@protocol LoginPageDelegate <NSObject>
@required

- (void)loginPageFinished:

@end

@interface LoginPageViewController : UIViewController <LoginModelDelegate>



@end
