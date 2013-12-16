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

#import "AGEncryptedSQLiteStorage.h"
#import "AGSQLiteCommand.h"

@implementation AGEncryptedSQLiteStorage

// ==============================================
// ======== 'factory' and 'init' section ========
// ==============================================

-(id) initWithConfig:(id<AGStoreConfig>) storeConfig {
    self = [super init];
    if (self) {
        _type = @"ENCRYPTED_SQLITE";

        AGStoreConfiguration* config = (AGStoreConfiguration*) storeConfig;
        _recordId = config.recordId;

        // extract file path
        _path = [self getFilePath];
        _databaseName = config.name;

        // if file exists open DB, if file not exist create an empty one
        _database = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@.sqlite3", [_path stringByAppendingPathComponent:_databaseName]]];
        NSLog(@"Database in %@",[_path stringByAppendingPathComponent:_databaseName]);

        _encoder = [[AGEncryptedPListEncoder alloc] initWithEncryptionService:storeConfig.encryptionService];

        _command = [[AGSQLiteCommand alloc] initWithDatabase:_database name:_databaseName recordId:_recordId encoder:_encoder];
    }

    return self;
}

// =====================================================
// =========== private utility methods  ================
// =====================================================
-(NSString*) getFilePath {
    // calculate path
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];

    // create the Documents directory if it doesn't exist
    BOOL isDir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory isDirectory:&isDir]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory
                                  withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return documentsDirectory;

}

@end
