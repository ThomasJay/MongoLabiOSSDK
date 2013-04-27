//
//  ViewController.h
//  MongoLab
//
//  Created by Tom Jay on 4/27/13.
//  Copyright (c) 2013 Tom Jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)getDatabaseListButtonPressed:(id)sender;
- (IBAction)getCollectionListButtonPressed:(id)sender;
- (IBAction)getCollectionItemListButtonPressed:(id)sender;
- (IBAction)insertCollectionItemStringButtonPressed:(id)sender;
- (IBAction)insertCollectionItemDictionaryButtonPressed:(id)sender;
- (IBAction)getCollectionItemButtonPressed:(id)sender;
- (IBAction)deleteCollectionItemButtonPressed:(id)sender;
- (IBAction)updateCollectionItemButtonPressed:(id)sender;

@end
