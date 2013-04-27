//
//  ViewController.m
//  MongoLab
//
//  Created by Tom Jay on 4/27/13.
//  Copyright (c) 2013 Tom Jay. All rights reserved.
//

#import "ViewController.h"
#import "MongoLabSDK.h"

@interface ViewController ()

@end

@implementation ViewController


// Setup your API Key from the mongolab.com portal

//TODO - Enter your Mongolab API Key
#define MY_APIKEY @""

//TODO - Enter database name - you can have multiple databases being used
#define MY_DATABASE @""

//TODO - Enter collection name for tests
#define MY_COLLECTION @""

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[MongoLabSDK sharedInstance] setupSDKWithKey:MY_APIKEY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




- (IBAction) getDatabaseListButtonPressed:(id)sender {
    
    [NSThread detachNewThreadSelector:@selector(getDatabaseListBackgroundThread) toTarget:self withObject:nil];
}

-(void) getDatabaseListBackgroundThread {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    NSArray *resultList = [[MongoLabSDK sharedInstance] getDatabaseList];
    
    for (NSString *dbName in resultList) {
        
        NSLog(@"getDatabaseListBackgroundThread dbName=%@", dbName);
    }
    
    [pool release];
    
}




- (IBAction)getCollectionListButtonPressed:(id)sender {
    
    [NSThread detachNewThreadSelector:@selector(getCollectionListBackgroundThread) toTarget:self withObject:nil];
}

-(void) getCollectionListBackgroundThread {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    NSArray *resultList = [[MongoLabSDK sharedInstance] getCollectionList:MY_DATABASE];
    
    for (NSString *collectionName in resultList) {
        
        NSLog(@"getCollectionLisBackgroundThread collectionName=%@", collectionName);
    }
    
    [pool release];
    
}



- (IBAction)getCollectionItemListButtonPressed:(id)sender {
    
    [NSThread detachNewThreadSelector:@selector(getCollectionItemListBackgroundThread) toTarget:self withObject:nil];
}

-(void) getCollectionItemListBackgroundThread {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    NSArray *resultList = [[MongoLabSDK sharedInstance] getCollectionItemList:MY_DATABASE collectionName:MY_COLLECTION];
    
    for (NSObject *item in resultList) {
        
        NSLog(@"getCollectionItemListBackgroundThread item=%@", item);
    }
    
    [pool release];
    
}



- (IBAction)insertCollectionItemStringButtonPressed:(id)sender {
    
    [NSThread detachNewThreadSelector:@selector(insertCollectionItemStringBackgroundThread) toTarget:self withObject:nil];
}

-(void) insertCollectionItemStringBackgroundThread {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    NSDictionary *resultList = [[MongoLabSDK sharedInstance] insertCollectionItem:MY_DATABASE collectionName:MY_COLLECTION stringData:@"{ \"name\":\"Bob\"}"];
    
    NSDictionary *itemIdDictionary = [resultList valueForKey:@"_id"];
    NSString *itemId = [itemIdDictionary valueForKey:@"$oid"];
    
    NSLog(@"insert itemId=%@", itemId);
    
    [pool release];
    
}




- (IBAction)insertCollectionItemDictionaryButtonPressed:(id)sender {
    
    [NSThread detachNewThreadSelector:@selector(insertCollectionItemBackgroundThread) toTarget:self withObject:nil];    
}

-(void) insertCollectionItemBackgroundThread {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    [item setValue:@"Alen" forKey:@"name"];
    [item setValue:@"200 B Street." forKey:@"address"];
    
    NSDictionary *resultList = [[MongoLabSDK sharedInstance] insertCollectionItem:MY_DATABASE collectionName:MY_COLLECTION item:item];
    
    NSDictionary *itemIdDictionary = [resultList valueForKey:@"_id"];
    NSString *itemId = [itemIdDictionary valueForKey:@"$oid"];
    
    NSLog(@"insert itemId=%@", itemId);
    
    [pool release];
    
}




- (IBAction)getCollectionItemButtonPressed:(id)sender {
    
    [NSThread detachNewThreadSelector:@selector(getCollectionItemBackgroundThread) toTarget:self withObject:nil];
}

-(void) getCollectionItemBackgroundThread {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    //@"{\"_id\":\"517af961e4b0352ee5ae9674\"}"
    //    NSArray *resultList = [[MongoLabSDK sharedInstance] getCollectionItemList:MY_DATABASE collectionName:MY_COLLECTION
    //                                                                        query:@"{\"name\":\"Tom\"}" countOnly:FALSE fields:nil  findOne:FALSE
    //                                                                    sortOrder:nil skip:0 limit:0];
    
    //    NSArray *resultList = [[MongoLabSDK sharedInstance] getCollectionItemList:MY_DATABASE collectionName:MY_COLLECTION
    //                                                                        query:@"{\"_id\" : { \"$oid\" : \"517af961e4b0352ee5ae9674\"}}" countOnly:FALSE fields:nil  findOne:FALSE
    //                                                                    sortOrder:nil skip:0 limit:0];
    
    NSArray *resultList = [[MongoLabSDK sharedInstance] getCollectionItemList:MY_DATABASE collectionName:MY_COLLECTION
                                                                        query:nil countOnly:FALSE fields:nil  findOne:TRUE
                                                                    sortOrder:nil skip:0 limit:0];
    
    
    for (NSObject *item in resultList) {
        
        NSLog(@"getCollectionItemButtonPressed=%@", item);
    }
    
    
    [pool release];
    
}



- (IBAction)deleteCollectionItemButtonPressed:(id)sender {
    
    [NSThread detachNewThreadSelector:@selector(deleteBackgroundThread) toTarget:self withObject:nil];
}


-(void) deleteBackgroundThread {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    NSDictionary *deletedItem = [[MongoLabSDK sharedInstance] deleteCollectionItem:MY_DATABASE collectionName:MY_COLLECTION itemId:@"517b3403e4b074a72fc6845e"];
    
    
    if (deletedItem == nil) {
        NSLog(@"deleteCollectionItemButtonPressed not found!");
    }
    else {
        NSLog(@"deleteCollectionItemButtonPressed Item deleted found=%@", deletedItem);
    }
    
    
    [pool release];
    
}


- (IBAction)updateCollectionItemButtonPressed:(id)sender {
    [NSThread detachNewThreadSelector:@selector(updateCollectionItemBackgroundThread) toTarget:self withObject:nil];
}

-(void) updateCollectionItemBackgroundThread {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSDictionary *updatedItem = [[MongoLabSDK sharedInstance] updateCollectionItem:MY_DATABASE collectionName:MY_COLLECTION
                                                    stringData:@"{$set: { \"x\" : 3 } }" query:@"{\"_id\" : { \"$oid\" : \"517b33ffe4b074a72fc6845d\"}}"];
    

    
    if (updatedItem == nil) {
        NSLog(@"updateCollectionItemBackgroundThread not found!");
    }
    else {
        NSLog(@"updateCollectionItemBackgroundThread Item deleted found=%@", updatedItem);
    }
    
    
    [pool release];
    
}





@end
