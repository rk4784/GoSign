//
//  GSUserTransactionHistoryViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 11/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserTransactionHistoryViewController.h"

@interface GSUserTransactionHistoryViewController ()

@end

@implementation GSUserTransactionHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"NewTitle"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    NSLog(@"1111");
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
