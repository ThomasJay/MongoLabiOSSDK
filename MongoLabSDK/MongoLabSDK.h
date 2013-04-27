//
//  MongoLabSDK.h
//  MongoLab
//
//  Created by Tom Jay on 4/27/13.
//  Copyright (c) 2013 Tom Jay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MongoLabSDK : NSObject

@property (strong, nonatomic) NSString *mongoLabAPIKey;

+(MongoLabSDK *) sharedInstance;

-(void) setupSDKWithKey:(NSString*) key;


// Get a list of your Databases
-(NSArray *) getDatabaseList;

// Get a list of your Collections in your Database
-(NSArray *) getCollectionList:(NSString *) databaseName;

// Get all items in a Collection
-(NSArray *) getCollectionItemList:(NSString *) databaseName collectionName:(NSString *) collectionName;

// Get a specific set of items or single item from a collection - Query is JSON and is encoded for you so send in raw json
-(NSArray *) getCollectionItemList:(NSString *) databaseName collectionName:(NSString *) collectionName query:(NSString *) query countOnly:(BOOL)  countOnly fields:(NSString *) fields  findOne:(BOOL) findOne sortOrder:(NSString *) sortOrder skip:(int) skip limit:(int) limit;

// Insert item into database/collection from NSDictionary object
-(NSDictionary *) insertCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName item:(NSDictionary *) item;

// Insert item into database/collection from NSString raw json object
-(NSDictionary *) insertCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName stringData:(NSString *) stringData;

// Update complete exisitng document, if upsert is set, insert if query is not found
-(NSDictionary *) updateCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName item:(NSDictionary *) item query:(NSString *) query  upsert:(BOOL) upsert;

// Update existing document with json string data for example, change a single value or add a new value
-(NSDictionary *) updateCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName stringData:(NSString *) stringData query:(NSString *) query;

// Delete item in a Collection
-(NSDictionary *) deleteCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName itemId:(NSString *) itemId;


@end
