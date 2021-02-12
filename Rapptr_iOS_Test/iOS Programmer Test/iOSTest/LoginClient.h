//
//  LoginClient.h
//  iOSTest
//
//  Created by Sajan Shrestha on 2/12/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginClient : NSObject
- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSDictionary *))completion;
@end
