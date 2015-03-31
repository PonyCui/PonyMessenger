//
//  PPMCoreData.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMPrivateCoreData.h"
#import <CoreData/CoreData.h>

@interface PPMPrivateCoreData ()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation PPMPrivateCoreData

- (instancetype)initWithUserID:(NSNumber *)userID
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
                           URLByAppendingPathComponent:[NSString stringWithFormat:@"PPM.%@.sqlite", userID]];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:options error:&error];
        
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        _managedObjectContext.undoManager = nil;
        _cacheStore = [[NSUserDefaults alloc]
                       initWithSuiteName:[NSString stringWithFormat:@"PPM.%@.userDefaults", userID]];
    }
    return self;
}

- (void)fetchUserInformationWithPredicate:(NSPredicate *)predicate
                          completionBlock:(PPMPrivateCoreDataUserInformationFetchCompletionBlock)completionBlock {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"UserInformation"];
    [request setPredicate:predicate];
    [self.managedObjectContext performBlock:^{
        NSArray *result = [self.managedObjectContext executeFetchRequest:request error:NULL];
        completionBlock(result);
    }];
}

- (PPMManagedUserInformationItem *)newUserInformationItem {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserInformation"
                                                         inManagedObjectContext:self.managedObjectContext];
    PPMManagedUserInformationItem *newEntry = (PPMManagedUserInformationItem *)[[NSManagedObject alloc]
                                                                                initWithEntity:entityDescription
                                                                insertIntoManagedObjectContext:self.managedObjectContext];
    return newEntry;
}

- (void)fetchUserRelationWithPredicate:(NSPredicate *)predicate
                     completionBlock:(PPMPrivateCoreDataUserRelationFetchCompletionBlock)completionBlock {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"UserRelation"];
    [request setPredicate:predicate];
    [self.managedObjectContext performBlock:^{
        NSArray *result = [self.managedObjectContext executeFetchRequest:request error:NULL];
        completionBlock(result);
    }];
}

- (PPMManagedUserRelationItem *)newUserRelationItem {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserRelation"
                                                         inManagedObjectContext:self.managedObjectContext];
    PPMManagedUserRelationItem *newEntry = (PPMManagedUserRelationItem *)[[NSManagedObject alloc]
                                                                                initWithEntity:entityDescription
                                                                                insertIntoManagedObjectContext:self.managedObjectContext];
    return newEntry;
}

- (void)save {
    [self.managedObjectContext save:NULL];
}

- (void)deleteManagedItem:(NSManagedObject *)managedItem {
    [self.managedObjectContext performBlock:^{
        [self.managedObjectContext deleteObject:managedItem];
        [self.managedObjectContext save:NULL];
    }];
}

@end
