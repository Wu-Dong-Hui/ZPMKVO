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

@interface ZPMViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ZPMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    
    [self.name ZPM_addObserver:self forKey:@"text" withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        [weakSelf showAlert:observedObject observerKey:observedKey oldValue:oldValue newValue:newValue];
    }];
    
    [self.password ZPM_addObserver:self forKey:@"text" withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
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
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:true completion:^{
            
        }];
    });
}
- (IBAction)loginClick:(UIButton *)sender {
    ZPMViewController *vc = [[ZPMViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
}
- (void)dealloc {
    [self.name ZPM_removeObserver:self forKey:@"text"];
    NSLog(@"%@", self.class);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
