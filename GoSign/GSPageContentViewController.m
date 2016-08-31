//
//  GSPageContentViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 20/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSPageContentViewController.h"

@interface GSPageContentViewController ()

@end

@implementation GSPageContentViewController
    @synthesize titleLabel;
    @synthesize backgroundImageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    // Do any additional setup after loading the view.
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
