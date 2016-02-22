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

+ (NSDictionary *)serializeObjectToDictionary:(id)pObj
{
    User *obj = pObj;
    
    if (obj == nil)
    {
        return nil;
    }
    
    NSDictionary *dict = [[NSDictionary alloc] init];
    [dict setValue:obj.username forKey:@"username"];
    [dict setValue:obj.userID forKey:@"userID"];
    [dict setValue:[FriendsList serializeObjectToDictionary:obj.friends] forKey:@"friendsList"];
    [dict setValue:[MusicalTaste serializeObjectToDictionary:obj.taste] forKey:@"musicalTaste"];
    
    return dict;
}

@end
