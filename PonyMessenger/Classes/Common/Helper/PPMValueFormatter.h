//
//  AFUObjectFormater.h
//  AFUtils
//
//  Created by 崔 明辉 on 14/12/22.
//  Copyright (c) 2014年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef PPMObjectFormatterMacros

    #define PPMObjectFormatterMacros

    #define TOString(object) (NSString *)[PPMValueFormatter objectAsClass:[NSString class] withObject:object]
    #define TONumber(object) (NSNumber *)[PPMValueFormatter objectAsClass:[NSNumber class] withObject:object]
    #define TOInteger(object) [[PPMValueFormatter objectAsClass:[NSNumber class] withObject:object] integerValue]
    #define TOFloat(object) [[PPMValueFormatter objectAsClass:[NSNumber class] withObject:object] floatValue]
    #define TODictionary(object) (NSDictionary *)[PPMValueFormatter objectAsClass:[NSDictionary class] withObject:object]
    #define TOArray(object) (NSArray *)[PPMValueFormatter objectAsClass:[NSArray class] withObject:object]
    #define ISValidArray(theObject, theIndex) (BOOL)[PPMValueFormatter isValidArray:theObject atIndex:theIndex]

#endif

@interface PPMValueFormatter : NSObject

+ (id)objectAsClass:(Class)argClass withObject:(id)argObject;

+ (BOOL)isValidArray:(id)argObject atIndex:(NSUInteger)argIndex;

@end
