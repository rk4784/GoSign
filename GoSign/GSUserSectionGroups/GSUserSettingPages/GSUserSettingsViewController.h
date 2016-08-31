//
//  GSUserSettingsViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 20/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSUserSettingsViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *updateButtonOutlet;
@property (weak, nonatomic) IBOutlet UISwitch *loggedInSwitchOutlet;
@property (weak, nonatomic) IBOutlet UITextField *userSeetingFullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userSeetingEmailIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userSeetingPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *userSeetingPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userSeetingDateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UITextField *userSeetingTimeOfBirthTextField;
- (IBAction)userUpdateButtonClicked:(id)sender;
- (IBAction)loggedInSwitchValueChanged:(id)sender;
-(void)userUpdateSendRequestToServer;

@end
