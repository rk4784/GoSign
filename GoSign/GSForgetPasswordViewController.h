//
//  GSForgetPasswordViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 10/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSForgetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *forgetPasswordBackgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *forgotPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *enterEmailLabel;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButtonOutlet;
- (IBAction)sendLinkButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *forgotPasswordEmailTextField;

@end
