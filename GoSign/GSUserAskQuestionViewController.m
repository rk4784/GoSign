//
//  GSUserAskQuestionViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 12/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserAskQuestionViewController.h"

@interface GSUserAskQuestionViewController ()

@end

@implementation GSUserAskQuestionViewController
@synthesize signatureMode;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    if([signatureMode  isEqual: @"ModifySignature"]) {
        NSLog(@"ModifySignature");
    } else if([signatureMode isEqualToString:@"RedesignSignature"]) {
        NSLog(@"RedesignSignature");
    } else if([signatureMode isEqualToString:@"ViewSignature"]) {
        NSLog(@"ViewSignature");
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signature Method"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"Redesign"
                                              otherButtonTitles:@"Modify",nil];
        [alert show];
    }
}
@end
