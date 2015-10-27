//
//  GzNetworking.m
//  GzoneLib
//
//  Created by Nguyen Dung on 21/11/2014.
//  Copyright (c) Năm 2014 dungnt. All rights reserved.
//

#import "GzNetworking.h"

@implementation GzNetworking

+ (instancetype)sharedInstance {
    return [GzNetworking shareInstanceWithValue:nil Header:nil];
}

+ (instancetype)shareInstanceWithValue:(NSString *)value Header:(NSString *)header {
    return [GzNetworking shareInstanceWithValue:value Header:header UserName:nil PassWord:nil];
}

+ (instancetype)shareInstanceWithToken_Key:(NSString *)token {
    return [GzNetworking shareInstanceWithValue:token Header:@"X-Auth-Token"];
}

+ (instancetype)sharedInstanceWithUserName:(NSString *)userName PassWord:(NSString *)password {
    return [GzNetworking shareInstanceWithValue:nil Header:nil UserName:userName PassWord:password];
}

+ (instancetype)shareInstanceWithValue:(NSString *)value Header:(NSString *)header UserName:(NSString *)userName PassWord:(NSString *)password {
    static GzNetworking *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[GzNetworking alloc]initWithBaseURL:nil];
        _sharedInstance.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedInstance.securityPolicy.allowInvalidCertificates = YES;
        [_sharedInstance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        _sharedInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/x-www-form-urlencoded", nil];
    });

    if (value != nil) {
        [_sharedInstance.requestSerializer setValue:value forHTTPHeaderField:header];
    }
    if (userName != nil && password != nil) {
        [_sharedInstance.requestSerializer setAuthorizationHeaderFieldWithUsername:userName password:password];
    }

    return _sharedInstance;
}

+ (instancetype)shareInstanceWithCustomHeader:(NSDictionary *)header UserName:(NSString *)userName PassWord:(NSString *)password {
    static GzNetworking *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[GzNetworking alloc]initWithBaseURL:nil];
        _sharedInstance.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedInstance.securityPolicy.allowInvalidCertificates = YES;
        [_sharedInstance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        _sharedInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/x-www-form-urlencoded", nil];
    });

    if (header != nil) {
        for (NSString *key in header.allKeys) {
            [_sharedInstance.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    if (userName != nil && password != nil) {
        [_sharedInstance.requestSerializer setAuthorizationHeaderFieldWithUsername:userName password:password];
    }

    return _sharedInstance;
}

- (void)GETCache:( NSString *)URLString
      parameters:( id)parameters
    refreshCache:(BOOL)refresh
         success:( void (^)( id responseString))success
         failure:( void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    if ([[EGOCache globalCache] hasCacheForKey:URLString]) {
        success([[EGOCache globalCache] stringForKey:URLString]);
        if (refresh) {
            [self GET:URLString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                if (operation.responseString) {
                    [[EGOCache globalCache] setString:operation.responseString forKey:URLString];
                }
                
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                failure(operation,error);
            }];
        }
    }
    else {
        [self GET:URLString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if (operation.responseString) {
                [[EGOCache globalCache] setString:operation.responseString forKey:URLString];
            }
            success(operation.responseString);
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            failure(operation,error);
        }];
    }
}

@end
