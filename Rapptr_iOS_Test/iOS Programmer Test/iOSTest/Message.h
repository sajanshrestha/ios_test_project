//
//  Message.h
//  iOSTest
//
//  Created by Sajan Shrestha on 2/11/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSURL *avatarURL;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *id;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithTestName:(NSString *)name withTestMessage:(NSString *)message;
@end
