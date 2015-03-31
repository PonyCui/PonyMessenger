//
//  PPMPublicCoreData.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMPublicCoreData.h"
#import <CoreData/CoreData.h>
#import "PPMManagedAccountItem.h"

@interface PPMPublicCoreData ()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation PPMPublicCoreData

+ (PPMPublicCoreData *)sharedCoreData {
    static PPMPublicCoreData *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PPMPublicCoreData alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        NSError *error = nil;
        NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        NSURL *storeURL = [applicationDocumentsDirectory
                           URLByAppendingPathComponent:[NSString stringWithFormat:@"PPM.%@.sqlite", @"0"]];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:options error:&error];
        
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        _managedObjectContext.undoManager = nil;
    }
    return self;
}

- (void)fetchAccountItemsWithCompletionBlock:(PPMPublicCoreDataAccountItemsFetchingCompletionBlock)completionBlock {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Account"];
    [self.managedObjectContext performBlock:^{
        NSArray *items = [self.managedObjectContext executeFetchRequest:request error:NULL];
        completionBlock(items);
    }];
}

- (void)fetchAccountItemWithUserID:(NSNumber *)userID comletionBlock:(PPMPublicCoreDataAccountItemFetchingCompletionBlock)completionBlock {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Account"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"user_id = %@", userID]];
    [self.managedObjectContext performBlock:^{
        NSArray *items = [self.managedObjectContext executeFetchRequest:request error:NULL];
        completionBlock([items firstObject]);
    }];
}

- (void)deleteAccountItem:(PPMManagedAccountItem *)item {
    [self.managedObjectContext performBlock:^{
        [self.managedObjectContext deleteObject:item];
        [self.managedObjectContext save:NULL];
    }];
}

- (PPMManagedAccountItem *)newAccountItem {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Account"
                                                         inManagedObjectContext:self.managedObjectContext];
    PPMManagedAccountItem *newEntry = (PPMManagedAccountItem *)[[NSManagedObject alloc]
                                                                 initWithEntity:entityDescription
                                                 insertIntoManagedObjectContext:self.managedObjectContext];
    
    return newEntry;
}

- (void)save {
    [self.managedObjectContext save:NULL];
}

@end
