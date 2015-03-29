//
//  PPMOutputHelper.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-29.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMOutputHelper.h"
#import "PPMValueFormatter.h"

@interface PPMOutputHelper ()

@property (nonatomic, strong) id JSONObject;

@property (nonatomic, strong) NSDictionary *eagerTypes;

@end

@implementation PPMOutputHelper

- (instancetype)initWithJSONObject:(id)JSONObject {
    return [self initWithJSONObject:JSONObject eagerTypes:nil];
}

- (instancetype)initWithJSONObject:(id)JSONObject eagerTypes:(NSDictionary *)eagerTypes {
    self = [super init];
    if (self && [JSONObject isKindOfClass:[NSDictionary class]]) {
        if ([JSONObject[@"error_code"] integerValue] != 0) {
            self.error = [NSError errorWithDomain:@"PPM.outputHelper"
                                             code:[JSONObject[@"error_code"] integerValue]
                                         userInfo:JSONObject[@"error_description"]];
        }
        self.JSONObject = JSONObject;
        self.eagerTypes = eagerTypes;
    }
    return self;
}

- (void)requestDataObjectWithCompletionBlock:(PPMOutputHelperRequestDataObjectCompletionBlock)completionBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        if (completionBlock) {
            completionBlock([self eagerTypesDataObject:self.JSONObject rootKey:nil][@"data"]);
        }
    });
}

- (id)eagerTypesDataObject:(id)theObject rootKey:(NSString *)rootKey {
    if (self.eagerTypes == nil) {
        return theObject;
    }
    else {
        if ([theObject isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mutableObject = [theObject mutableCopy];
            [(NSDictionary *)theObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if (self.eagerTypes[key] != nil) {
                    id eagerObject = [PPMValueFormatter objectAsClass:NSClassFromString(self.eagerTypes[key])
                                                           withObject:obj];
                    if (eagerObject != nil) {
                        [mutableObject setObject:eagerObject forKey:key];
                    }
                    else {
                        [mutableObject removeObjectForKey:key];
                    }
                }
                if ([mutableObject[key] isKindOfClass:[NSDictionary class]] ||
                    [mutableObject[key] isKindOfClass:[NSArray class]]) {
                    [mutableObject setObject:[self eagerTypesDataObject:mutableObject[key] rootKey:key]
                                      forKey:key];
                }
            }];
            return [mutableObject copy];
        }
        else if ([theObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *mutableObject = [theObject mutableCopy];
            [(NSArray *)theObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *arrayKey = [NSString stringWithFormat:@"%@[]", rootKey];
                if (self.eagerTypes[arrayKey] != nil) {
                    id eagerObject = [PPMValueFormatter
                                      objectAsClass:NSClassFromString(self.eagerTypes[arrayKey])
                                      withObject:obj];
                    if (eagerObject != nil) {
                        [mutableObject setObject:eagerObject atIndexedSubscript:idx];
                    }
                }
                if ([[mutableObject objectAtIndex:idx] isKindOfClass:[NSDictionary class]] ||
                    [[mutableObject objectAtIndex:idx] isKindOfClass:[NSArray class]]) {
                    [mutableObject setObject:[self eagerTypesDataObject:[mutableObject objectAtIndex:idx] rootKey:arrayKey]
                          atIndexedSubscript:idx];
                }
            }];
            return [mutableObject copy];
        }
        else {
            return theObject;
        }
    }
}

@end
