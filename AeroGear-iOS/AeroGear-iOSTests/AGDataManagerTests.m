/*
 * JBoss, Home of Professional Open Source.
 * Copyright 2012 Red Hat, Inc., and individual contributors
 * as indicated by the @author tags.
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

#import <SenTestingKit/SenTestingKit.h>
#import "AGStore.h"
#import "AGDataManager.h"

@interface AGDataManagerTests : SenTestCase

@end
@implementation AGDataManagerTests

-(void) testCreateDataManagerWithOneStore {
    AGDataManager* mgr = [AGDataManager manager];
    STAssertNotNil(mgr, @"storage could not be null");
    [mgr store:^(id<AGStoreConfig> config) {
        [config name:@"tasks"];
    }];
    
    id<AGStore> taskStore = [mgr get:@"tasks"];
    STAssertNotNil(taskStore, @"actual store could not be null");
    
    id<AGStore> noStore = [mgr get:@"foobar"];
    STAssertNil(noStore, @"actual store should be nil");
}

-(void) testCreateDataManagerAndAddStores {
    AGDataManager* mgr = [AGDataManager manager];
    [mgr store:^(id<AGStoreConfig> config) {
        [config name:@"tasks"];
    }];
    [mgr store:^(id<AGStoreConfig> config) {
        [config name:@"projects"];
        [config type:@"MEMORY"];
    }];
    [mgr store:^(id<AGStoreConfig> config) {
        [config name:@"tags"];
    }];
    
    id<AGStore> taskStore = [mgr get:@"tasks"];
    STAssertNotNil(taskStore, @"actual store could not be null");
    id<AGStore> tagStore = [mgr get:@"tags"];
    STAssertNotNil(tagStore, @"actual store could not be null");
    id<AGStore> projectStore = [mgr get:@"projects"];
    STAssertNotNil(projectStore, @"actual store could not be null");
}
    
-(void) testCreateDataManagerAndAddAndRemoveStores {
    AGDataManager* mgr = [AGDataManager manager];
    [mgr store:^(id<AGStoreConfig> config) {
        [config name:@"tasks"];
    }];
    [mgr store:^(id<AGStoreConfig> config) {
        [config name:@"projects"];
        [config type:@"MEMORY"];
    }];
    [mgr store:^(id<AGStoreConfig> config) {
        [config name:@"tags"];
    }];
    
    id<AGStore> taskStore = [mgr get:@"tasks"];
    STAssertNotNil(taskStore, @"actual store could not be null");
    // check default type:
    STAssertEqualObjects(@"MEMORY", taskStore.type, @"has expected MEMORY type");
    
    id<AGStore> tagStore = [mgr get:@"tags"];
    STAssertNotNil(tagStore, @"actual store could not be null");
    id<AGStore> projectStore = [mgr get:@"projects"];
    STAssertNotNil(projectStore, @"actual store could not be null");
    // check type:
    STAssertEqualObjects(@"MEMORY", projectStore.type, @"has expected MEMORY type");

    projectStore = [mgr remove:@"projects"];
    STAssertNotNil(projectStore, @"actual store could not be null");
    projectStore = [mgr get:@"projects"];
    STAssertNil(projectStore, @"actual store should be null");
}

-(void) testCreateDataManagerAndAddWrongStoreType {
    AGDataManager* mgr = [AGDataManager manager];
    id<AGStore> noStore = [mgr store:^(id<AGStoreConfig> config) {
        [config name:@"projects"];
        [config type:@"FOOBAR"];
    }];
    STAssertNil(noStore, @"actual store should be null");
}

@end
