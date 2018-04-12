//
//  ZPMSendReadViewController.m
//  ZPMKVO_Example
//
//  Created by Roy on 2018/4/12.
//  Copyright © 2018年 Wu-Dong-Hui. All rights reserved.
//

#import "ZPMFirstViewController.h"
#import "Marco.h"

@interface ZPMFirstViewController ()

@end

@implementation ZPMFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)sendRead:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:ReadNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
