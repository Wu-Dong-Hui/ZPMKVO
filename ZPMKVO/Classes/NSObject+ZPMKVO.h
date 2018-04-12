//
//  NSObject+ZPMKVO.h
//  FBSnapshotTestCase
//
//  Created by Roy on 2018/4/11.
//

#import <Foundation/Foundation.h>

#import "ZPMKVO.h"

NSString *const kZPMKVOClassPrefix = @"ZPMKVOClassPrefix_";
NSString *const kZPMKVOAssociatedObservers = @"ZPMKVOAssociatedObservers";

@interface NSObject (ZPMKVO)

- (void)ZPM_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(ZPMObservingBlock)block;

- (void)ZPM_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
