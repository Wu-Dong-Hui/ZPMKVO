//
//  ZPMViewController.m
//  ZPMKVO
//
//  Created by Wu-Dong-Hui on 04/11/2018.
//  Copyright (c) 2018 Wu-Dong-Hui. All rights reserved.
//

#import "ZPMViewController.h"
#import <ZPMKVO/NSObject+ZPMKVO.h>
#import "Marco.h"


@interface Person: NSObject
@property (nonatomic, copy) NSString *name;
@end

@implementation Person
- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}
@end




@interface ZPMViewController ()
@property (strong, nonatomic) UIButton *button;
@property (nonatomic, strong) Person *person;

@end

@implementation ZPMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.person = [[Person alloc] initWithName:@"Li"];
    
    
    __weak typeof(self) weakSelf = self;
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(10, 100, 300, 30);
    [self.button setTitle:[NSString stringWithFormat:@"Press me to change name %@", self.person.name] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(changeTitle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    [self.person ZPM_addObserver:self forKey:@"name" withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        [weakSelf showAlert:observedObject observerKey:observedKey oldValue:oldValue newValue:newValue];
    }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:ReadNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"%@", note.name);
        [self setTabBadge:nil];
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UnreadNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"%@", note.name);
        [self setTabBadge:@"1"];
    }];
}

- (void)setTabBadge:(NSString *)badge {
    self.navigationController.tabBarItem.badgeValue = badge;
}
- (void)showAlert:(id)observerObject observerKey:(NSString *)key oldValue:(id)old newValue:(id)new {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@.%@ chanaged from %@ to %@", [observerObject class], key, old, new);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@.%@ chanaged from %@ to %@", [observerObject class], key, old, new] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:true completion:^{
            
        }];
    });
}
- (void)changeTitle:(UIButton *)sender {
    NSArray *names = @[@"Li Lei", @"Han Meimei", @"Tom", @"John", @"Tony"];
    self.person.name = names[arc4random() % (names.count)];
    
    [sender setTitle:[NSString stringWithFormat:@"Press me to change name %@", self.person.name] forState:UIControlStateNormal];
}

- (void)dealloc {
    [self.person ZPM_removeObserver:self forKey:@"text"];
    NSLog(@"%@", self.class);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
