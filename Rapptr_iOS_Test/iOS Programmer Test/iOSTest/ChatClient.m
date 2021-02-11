//
//  ChatClient.m
//  iOSTest
//
//  Created by Sajan Shrestha on 2/11/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

#import "ChatClient.h"

@interface ChatClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ChatClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 **/

- (void)fetchChatData:(void (^)(NSArray<Message *> *))completion withError:(void (^)(NSString *error))errorBlock
{
    NSString *urlString = @"http://dev.rapptrlabs.com/Tests/scripts/chat_log.php";
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *messageResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if (err) {
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSArray *fetchedData  = messageResponse[@"data"];
        NSMutableArray<Message *> *messages = NSMutableArray.new;
        
        for (NSDictionary *fetchedMessage in fetchedData) {
            Message *message = [[Message alloc] initWithDictionary:fetchedMessage];
            [messages addObject:message];
        }
        
        completion(messages);
        
    }] resume];
}

@end
