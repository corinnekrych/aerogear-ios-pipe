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

#import <OHHTTPStubs/OHHTTPStubs.h>

/**
 * Convenience class methods that use OHHTTPStubs for
 * mocking HTTP communication interactions.
 */
@interface AGHTTPMockHelper : NSObject

+ (void)mockResponseStatus:(int)status;

+ (void)mockResponse:(NSData*)data;

+ (void)mockResponse:(NSData *)data headers:(NSDictionary*)headers;

+ (void)mockResponse:(NSData *)data status:(int)status requestTime:(NSTimeInterval)requestTime;

+ (void)mockResponse:(NSData *)data
             headers:(NSDictionary *)headers
              status:(int)status
         requestTime:(NSTimeInterval)requestTime;

+ (NSString*)lastHTTPMethodCalled;

+ (NSDictionary*)lastHTTPRequestHeaders;

+ (void)clearAllMockedRequests;

@end