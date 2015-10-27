//
//  GzNetworking.h
//  GzoneLib
//
//  Created by Nguyen Dung on 21/11/2014.
//  Copyright (c) Năm 2014 dungnt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <EGOCache.h>

@interface GzNetworking : AFHTTPRequestOperationManager

/*********** Basic Request ***********/
+ (instancetype)sharedInstance;

/*********** Request With Custom Header ***********/
+ (instancetype) shareInstanceWithValue:(NSString *)value Header:(NSString *)header;

/*********** Request With Authen ***********/
+ (instancetype )shareInstanceWithToken_Key:(NSString *)token;

/*********** Request With Basic Authen ***********/
+ (instancetype )sharedInstanceWithUserName:(NSString *)userName PassWord:(NSString *)password;

/*********** Full Request ***********/
+ (instancetype) shareInstanceWithValue:(NSString *)value Header:(NSString *)header UserName:(NSString *)userName PassWord:(NSString *)password;

/*********** multi header ***********/
+ (instancetype) shareInstanceWithCustomHeader:(NSDictionary *)header UserName:(NSString *)userName PassWord:(NSString *)password;

- (void)GETCache:( NSString *)URLString
                              parameters:( id)parameters
                            refreshCache:(BOOL)refresh
                                 success:( void (^)( id responseString))success
                                 failure:( void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
