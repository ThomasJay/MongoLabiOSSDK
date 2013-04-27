//
//  MongoLabSDK.m
//  MongoLab
//
//  Created by Tom Jay on 4/27/13.
//  Copyright (c) 2013 Tom Jay. All rights reserved.
//

//
// Reference Docs from MongoLab.com
// https://support.mongolab.com/entries/20433053-REST-API-for-MongoDB
//
//

// List documents - Notes
//
// GET /databases/{database}/collections
//
// Optional parameters:
// [q=<query>][&c=true][&f=<fields>][&fo=true][&s=<order>][&sk=<skip>][&l=<limit>]
//
// q=<query> - restrict results by the specified JSON query
// c=true - return the result count for this query
// f=<set of fields> - specify the set of fields to include or exclude in each document (1 - include; 0 - exclude)
// fo=true - return a single document from the result set (same as findOne() using the mongo shell
// s=<sort order> - specify the order in which to sort each specified field (1- ascending; -1 - descending)
// sk=<num results to skip> - specify the number of results to skip in the result set; useful for paging
// l=<limit> - specify the limit for the number of results (default is 1000)
//
//
// query countOnly fields findOne sortOrder skip limit
//
//
//
//
// Update multiple documents - Notes
//
// PUT /databases/{database}/collections/{collection}
//
// Optional parameters:
// [q=<query>][&m=true][&u=true]
//
// q=<query> - only update document(s) matching the specified JSON query
// m=true - update all documents collection or query (if specified).  By default only one document is modified
// u=true - "upsert": insert the document defined in the request body if none match the specified query
//
//

//
// Query Example - {"_id":1234}
//




#import "MongoLabSDK.h"
#import "JSON.h"

@implementation MongoLabSDK

@synthesize mongoLabAPIKey;


MongoLabSDK *MongoLabSDK_INSTANCE = nil;

+(MongoLabSDK *) sharedInstance {
    
    if (MongoLabSDK_INSTANCE == nil) {
        
        MongoLabSDK_INSTANCE = [[MongoLabSDK alloc] init];
        
        [MongoLabSDK_INSTANCE retain];
                
    }
    
    return MongoLabSDK_INSTANCE;
    
}



-(void) setupSDKWithKey:(NSString *) keyParam {
    self.mongoLabAPIKey = keyParam;
}


-(NSArray *) getDatabaseList {
    
    NSURLResponse *response = nil;
    NSError *error = nil;

    NSString *urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases?apiKey=%@", mongoLabAPIKey];
    
    NSURL *url = [[[NSURL alloc] initWithString:urlString] autorelease];

    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"GET"];

    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (receivedData != nil) {
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        
        NSObject *json = [responseString JSONValue];
        
        if ([json isKindOfClass:[NSArray class]]) {
            return (NSArray*)json;
        }
        
        
    }
    
    
    return nil;
}


-(NSArray *) getCollectionList:(NSString *) databaseName {
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases/%@/collections?apiKey=%@", databaseName, mongoLabAPIKey];
    
    NSURL *url = [[[NSURL alloc] initWithString:urlString] autorelease];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (receivedData != nil) {
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        
        NSObject *json = [responseString JSONValue];
        
        if ([json isKindOfClass:[NSArray class]]) {
            return (NSArray*)json;
        }
        
        
    }
    
    
    return nil;
}

-(NSArray *) getCollectionItemList:(NSString *) databaseName collectionName:(NSString *) collectionName {
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases/%@/collections/%@?apiKey=%@", databaseName, collectionName, mongoLabAPIKey];
    
    NSURL *url = [[[NSURL alloc] initWithString:urlString] autorelease];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (receivedData != nil) {
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        
        NSObject *json = [responseString JSONValue];
        
        if ([json isKindOfClass:[NSArray class]]) {
            return (NSArray*)json;
        }
        
        
    }
    
    
    return nil;
}

-(NSArray *) getCollectionItemList:(NSString *) databaseName collectionName:(NSString *) collectionName query:(NSString *) query countOnly:(BOOL)  countOnly fields:(NSString *) fields  findOne:(BOOL) findOne sortOrder:(NSString *) sortOrder skip:(int) skip limit:(int) limit {
    
    
    NSString *urlString = @"";
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSString *queryParams = @"";
    if (query != nil && [query length] > 0) {
        queryParams = [NSString stringWithFormat:@"&q=%@", [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
        

        NSString *fieldsParams = @"";
        if (fields != nil && [fields length] > 0) {
            fieldsParams = [NSString stringWithFormat:@"&f=%@", fields];
        }

        NSString *findOneParams = @"";
        if (findOne) {
            findOneParams = [NSString stringWithFormat:@"&fo=true"];
        }

        NSString *sortOrderParams = @"";
        if (sortOrder != nil && [sortOrder length] > 0) {
            sortOrder = [NSString stringWithFormat:@"&s=%@", sortOrder];
        }

        NSString *skipParams = @"";
        if (skip > 0) {
            skipParams = [NSString stringWithFormat:@"&sk=%d", skip];
        }

        NSString *limitParams = @"";
        if (limit  > 0) {
            limitParams = [NSString stringWithFormat:@"&l=%d", limit];
        }


        urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases/%@/collections/%@?apiKey=%@%@%@%@%@%@%@", databaseName, collectionName, mongoLabAPIKey, queryParams, fieldsParams, findOneParams, sortOrderParams, skipParams, limitParams];

        
    NSURL *url = [[[NSURL alloc] initWithString:urlString] autorelease];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (receivedData != nil) {
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];

        NSObject *json = [responseString JSONValue];
        
        if ([json isKindOfClass:[NSArray class]]) {
            return (NSArray*)json;
        }
        
        
    }
    
    
    return nil;
}


-(NSDictionary *) insertCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName item:(NSDictionary *) item {

    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases/%@/collections/%@?apiKey=%@", databaseName, collectionName, mongoLabAPIKey];
    
    NSURL *url = [[[NSURL alloc] initWithString:urlString] autorelease];
    
    
    NSString *body = [item JSONRepresentation];
        
    NSString *msgLength = [NSString stringWithFormat:@"%d", [body length]];

    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody: [body dataUsingEncoding:NSUTF8StringEncoding]];

    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];

    if (receivedData != nil) {
        
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        
        NSDictionary *json = [responseString JSONValue];
        
        return json;
                
    }
    
    
    return nil;

}

-(NSDictionary *) insertCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName stringData:(NSString *) stringData {
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases/%@/collections/%@?apiKey=%@", databaseName, collectionName, mongoLabAPIKey];
    
    NSURL *url = [[[NSURL alloc] initWithString:urlString] autorelease];
    
    
    NSString *body = stringData;
        
    NSString *msgLength = [NSString stringWithFormat:@"%d", [body length]];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody: [body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (receivedData != nil) {
        
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        
        NSDictionary *json = [responseString JSONValue];
        
        return json;
        
    }
    
    
    return nil;
    
}


-(NSDictionary *) updateCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName item:(NSDictionary *) item query:(NSString *) query  upsert:(BOOL) upsert {

    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    
    NSString *queryParams = @"";
    if (query != nil && [query length] > 0) {
        queryParams = [NSString stringWithFormat:@"&q=%@", [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *upsertParams = @"";
    if (upsert) {
        upsertParams = [NSString stringWithFormat:@"&u=true"];
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases/%@/collections/%@?apiKey=%@%@%@", databaseName, collectionName, mongoLabAPIKey, queryParams, upsertParams];
    
    NSURL *url = [[[NSURL alloc] initWithString:urlString] autorelease];
    
    
    NSString *body = [item JSONRepresentation];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [body length]];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPMethod:@"PUT"];
    [urlRequest setHTTPBody: [body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (receivedData != nil) {
        
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        
        NSDictionary *json = [responseString JSONValue];
        
        return json;
        
    }
    
    
    return nil;

}

-(NSDictionary *) updateCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName stringData:(NSString *) stringData query:(NSString *) query {
    
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSLog(@"updateCollectionItem started");
    NSString *queryParams = @"";
    if (query != nil && [query length] > 0) {
        queryParams = [NSString stringWithFormat:@"&q=%@", [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases/%@/collections/%@?apiKey=%@%@", databaseName, collectionName, mongoLabAPIKey, queryParams];

    NSLog(@"updateCollectionItem urlString=%@", urlString);

    NSURL *url = [[[NSURL alloc] initWithString:urlString] autorelease];
    
    
    NSString *body = stringData;
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [body length]];
    NSLog(@"updateCollectionItem body=%@", body);
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPMethod:@"PUT"];
    [urlRequest setHTTPBody: [body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (receivedData != nil) {
        
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        
        
        NSLog(@"updateCollectionItem responseString=%@", responseString);

        NSDictionary *json = [responseString JSONValue];
        
        return json;
        
    }
    
    
    return nil;

    
}



-(NSDictionary *) deleteCollectionItem:(NSString *) databaseName collectionName:(NSString *) collectionName itemId:(NSString *) itemId {
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases/%@/collections/%@/%@?apiKey=%@", databaseName, collectionName, itemId, mongoLabAPIKey];
    
    NSURL *url = [[[NSURL alloc] initWithString:urlString] autorelease];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"DELETE"];
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
    if (receivedData != nil) {
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];

        NSLog(@"deleteCollectionItem responseString=%@", responseString);
        NSObject *json = [responseString JSONValue];
            
        if ([json isKindOfClass:[NSDictionary class]]) {
            return (NSDictionary*)json;
        }
        
        
    }
    
    
    return nil;
    
}


@end
