//
//  ChatClient.h
//  iOSTest
//
//  Created by Sajan Shrestha on 2/11/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface ChatClient : NSObject
- (void)fetchChatData:(void (^)(NSArray<Message *> *))completion withError:(void (^)(NSString *error))errorBlock;
@end
