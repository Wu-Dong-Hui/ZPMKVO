//
//  UITextField+ZPMKVO.h
//  FBSnapshotTestCase
//
//  Created by Roy on 2018/4/11.
//

#import <UIKit/UIKit.h>
#import "ZPMKVO.h"

NSString *const kZPMKVOClassPrefix2 = @"ZPMKVOClassPrefix2_";
NSString *const kZPMKVOAssociatedObservers2 = @"ZPMKVOAssociatedObservers2";

@interface UITextField (ZPMKVO)
- (void)ZPM_addObserver:(NSObject *)observer
                 forKey:(NSString *)key
              withBlock:(ZPMObservingBlock)block;
- (void)ZPM_removeObserver:(NSObject *)observer forKey:(NSString *)key;
@end
