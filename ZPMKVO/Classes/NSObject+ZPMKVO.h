//
//  NSObject+ZPMKVO.h
//  FBSnapshotTestCase
//
//  Created by Roy on 2018/4/11.
//

#import <Foundation/Foundation.h>

typedef void(^ZPMObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (ZPMKVO)

- (void)ZPM_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(ZPMObservingBlock)block;

- (void)ZPM_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end

// Test1
