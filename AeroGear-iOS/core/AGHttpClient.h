/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AGAuthenticationModuleAdapter.h"
#import "AGAuthzModuleAdapter.h"

@interface AGHttpClient : AFHTTPSessionManager

@property (nonatomic, strong) id<AGAuthenticationModuleAdapter> authModule;
@property (nonatomic, strong) id<AGAuthzModuleAdapter> authzModule;

+ (instancetype)clientFor:(NSURL *)url;
+ (instancetype)clientFor:(NSURL *)url timeout:(NSTimeInterval)interval;
+ (instancetype)clientFor:(NSURL *)url timeout:(NSTimeInterval)interval sessionConfiguration:(NSURLSessionConfiguration *)configuration;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
