//
//  GSSignUpViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 20/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSSignUpViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *signUpPageBackgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *signUpButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *maleButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *femaleButtonOutlet;
@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UITextField *TimeOfBirthTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerOutlet;
- (IBAction)maleButtonClicked:(id)sender;
- (IBAction)femaleButtonClicked:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;
- (IBAction)signUpButtonClicked:(id)sender;
@end
