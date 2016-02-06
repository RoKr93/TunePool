//
//  DatabaseTalker.m
//  TunePool
//
//  Created by Evan Shenkman on 2/6/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "DatabaseTalker.h"

typedef void (^SuccessCallbackBlock)(NSURLSessionDataTask *task, id responseObject);

typedef void (^FailureCallbackBlock)(NSURLSessionDataTask *task, NSError *error);

@interface DatabaseTalker ()

@property (nonatomic, strong) NSString *serverName;
@property (nonatomic, strong) NSString *pathName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;

@property (nonatomic) AFHTTPSessionManager *connectionManager;

- (id)initWithServer:(NSString *)server andPath:(NSString *)path andUser:(NSString *)user andPassword:(NSString *)pass;

+ (SuccessCallbackBlock)successForCompletionBlock:(CompletionBlock)completionBlock;
+ (FailureCallbackBlock)failureForCompletionBlock:(CompletionBlock)completionBlock;

-(void)performAsyncServerCallWithParams:(NSDictionary*)params andSuccess:(SuccessCallbackBlock)success andFailure:(FailureCallbackBlock)failure;

@end

@implementation DatabaseTalker

#pragma mark - Initers

+ (DatabaseTalker *)getDatabaseTalker
{
    return [self getDatabaseTalkerForServer:nil andPath:nil andUser:nil andPassword:nil];
}

+ (DatabaseTalker *)getDatabaseTalkerForServer:(NSString *)server andPath:(NSString *)path andUser:(NSString *)user andPassword:(NSString *)pass
{
    static DatabaseTalker *dbCache;
    if (!dbCache)
    {
        dbCache = [[DatabaseTalker alloc] initWithServer:server andPath:path andUser:user andPassword:pass];
    }
    else
    {
        if (server)
        {
            dbCache.serverName = server;
        }
        if (path)
        {
            dbCache.pathName = path;
        }
    }
    
    return dbCache;
}

- (id)initWithServer:(NSString *)server andPath:(NSString *)path andUser:(NSString *)user andPassword:(NSString *)pass
{
    self = [super init];
    if (self)
    {
        //In router config
        //Use this computers IP Address to setup port forwarding
        //Apache is set up to listen on port 5400
        
        //SmartBar Server
        self.serverName = @"http://68.194.28.251:5400";
        
        //If running locally
        //self.serverName = @"localhost";
        
        if (server)
        {
            self.serverName = server;
        }
        
        //Path for the php script
        self.pathName = @"ButtStuff.php";
        if (path)
        {
            self.pathName = path;
        }
        
        self.userName = user;
        self.password = pass;
        
        //This will be a general NSURL thing or watevs
        self.connectionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.serverName]];
        self.connectionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.connectionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.connectionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    }
    
    return self;
}

+ (SuccessCallbackBlock)successForCompletionBlock:(CompletionBlock)completionBlock
{
    SuccessCallbackBlock success = ^(NSURLSessionDataTask *task, id responseObject)
    {
        if([responseObject isKindOfClass:[NSError class]])
        {
            NSLog(@"NETWORK ERROR: %@", responseObject);
            completionBlock(@{@"data": [NSNull null],
                              @"response": responseObject});
        }
        
        else
        {
            NSString *res = [responseObject objectForKey:@"response"];
            
            if([res isEqualToString:@"success"])
            {
                completionBlock((NSDictionary *)responseObject);
            }
            
            else
            {
                NSString *message = @"failure in web service";
                if(responseObject[@"message"] != nil)
                    message = responseObject[@"message"];
                
                //WHAT DO WE WANT TO DO HERE
                completionBlock(@{@"data": [NSNull null],
                                  @"message": message,
                                  @"response": @"failure"});
            }
        }
    };
    
    return success;
}

+ (FailureCallbackBlock)failureForCompletionBlock:(CompletionBlock)completionBlock
{
    FailureCallbackBlock failure = ^(NSURLSessionDataTask *task, NSError *error)
    {
        //TODO: what do we want to do here?
        completionBlock(@{@"data": [NSNull null],
                          @"message": @"failure in POST request",
                          @"response": @"failure"});
    };
    
    return failure;
}

//- (void)doHttpRequestWithUrl:(NSString *)urlString andCompletionBlock:(HttpResponse)completionBlock
//{
//    // create the request
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    
//    // send our request away
//    [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completionBlock];
//}

# pragma mark - Creating/Finding/Joining Playlist Sessions

- (void)createPlaylistSessionWithUser:(User *)user Name:(NSString *)name Location:(CLLocation *)location andCompletionBlock:(CompletionBlock)completionBlock
{
    NSDictionary *params = [[NSDictionary alloc] init];
    
    [params setValue:@"createPlaylistSession" forKey:@"operation"];
    [params setValue:user forKey:@"user"];
    [params setValue:name forKey:@"name"];
    [params setValue:location forKey:@"location"];
    
    SuccessCallbackBlock success = [DatabaseTalker successForCompletionBlock:completionBlock];
    FailureCallbackBlock failure = [DatabaseTalker failureForCompletionBlock:completionBlock];
    
    [self performAsyncServerCallWithParams:params andSuccess:success andFailure:failure];
}

#pragma mark - Perform Async Server Call

-(void)performAsyncServerCallWithParams:(NSDictionary*)params andSuccess:(SuccessCallbackBlock)success andFailure:(FailureCallbackBlock)failure
{
    [self.connectionManager POST:self.pathName parameters:params success:success failure:failure];
}

@end
