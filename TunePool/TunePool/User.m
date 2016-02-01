//
//  User.m
//  TunePool
//
//  Created by Evan Shenkman on 1/31/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "User.h"

#import "FriendsList.h"
#import "MusicalTaste.h"

@interface User ()

@property (nonatomic) NSString *username;
@property (nonatomic) NSString *userID;

@property (nonatomic) FriendsList *friends;
@property (nonatomic) MusicalTaste *taste;

- (id)init;

@end

@implementation User

- (id)init
{
    self = [super init];
    return self;
}

+ (User*)createUserWithSPTUser:(SPTUser *)user
{
    User *newUser = [[User alloc] init];
    
    newUser.username = user.displayName;
    NSString *uri = [user.uri absoluteString];
    // uri will always be spotify:user:id
    newUser.userID = [uri componentsSeparatedByString:@":"][2];
    
    return newUser;
}

@end
