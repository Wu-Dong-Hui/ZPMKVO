//
//  UITextField+ZPMKVO.m
//  FBSnapshotTestCase
//
//  Created by Roy on 2018/4/11.
//

#import "UITextField+ZPMKVO.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface ZPMObservationInfo2 : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) ZPMObservingBlock block;

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(ZPMObservingBlock)block;
@end

@implementation ZPMObservationInfo2

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(ZPMObservingBlock)block
{
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}
- (void)dealloc {
    NSLog(@"%@", self.class);
}
@end


@implementation UITextField (ZPMKVO)

- (void)ZPM_addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(ZPMObservingBlock)block {
    [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
    
    ZPMObservationInfo2 *info = [[ZPMObservationInfo2 alloc] initWithObserver:observer Key:key block:block];
    
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kZPMKVOAssociatedObservers2));
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)(kZPMKVOAssociatedObservers2), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray <ZPMObservationInfo2 *> *observers = objc_getAssociatedObject(self, (__bridge const void *)(kZPMKVOAssociatedObservers2));
        for (ZPMObservationInfo2 *info in observers) {
            if ([info.key isEqualToString:keyPath]) {
                info.block(self, keyPath, change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
            }
        }
    });
    
}
- (void)ZPM_removeObserver:(NSObject *)observer forKey:(NSString *)key {
    [self removeObserver:observer forKeyPath:key];
}

@end
