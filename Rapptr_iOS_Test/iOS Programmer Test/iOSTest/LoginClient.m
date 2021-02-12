//
//  LoginClient.m
//  iOSTest
//
//  Created by Sajan Shrestha on 2/12/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

#import "LoginClient.h"

@interface LoginClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation LoginClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 **/

- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSDictionary *))completion
{
    
    NSDate *start = [NSDate date];
    
    NSString *urlString = @"http://dev.rapptrlabs.com/Tests/scripts/login.php";
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    
    NSURLQueryItem *emailQueryItem = [NSURLQueryItem queryItemWithName:@"email" value:email];
    NSURLQueryItem *passwordQueryItem = [NSURLQueryItem queryItemWithName:@"password" value:password];
    NSArray* queryItems = @[ emailQueryItem, passwordQueryItem ];
    
    components.queryItems = queryItems;
    
    NSURL *url = [components URL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
        if (response) {
            NSTimeInterval timeInterval = [start timeIntervalSinceNow];
            double timeIntervalInMs = timeInterval * 1000;
            NSNumber *networkingTime = [NSNumber numberWithDouble:timeIntervalInMs];
            
            completion(@{@"Success" : @YES, @"NetworkingTime": networkingTime});
        }
        else {
            completion(@{@"Success" : @NO});
        }
            
    }] resume];

}

@end
