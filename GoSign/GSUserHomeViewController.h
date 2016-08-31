//
//  GSUserHomeViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 21/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSUserHomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *userHomeModifySignatureButtonOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *userHomePageBackgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *userHomeRedesignSignatureButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *userHomeContactUsButtonOutlet;
@property (weak, nonatomic) IBOutlet UILabel *mySignatureBackgroundLabel;
//- (IBAction)userHomeModifySignatureButtonClicked:(id)sender;
//- (IBAction)userHomeRedesignSignatureButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *userHomeMyAnbalysisLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHomeMySignaturelabel;

@end
