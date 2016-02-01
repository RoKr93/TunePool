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

+ (User*)createUserWithResponse:(NSDictionary *)res
{
    User *newUser = [[User alloc] init];
    
    //Extract the contents from the JSON Response
    
    return newUser;
}

@end
