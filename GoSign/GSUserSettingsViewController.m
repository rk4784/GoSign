//
//  GSUserSettingsViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 20/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserSettingsViewController.h"
#import "GSWebServicesCalling.h"
#import "GSLoginViewController.h"
#import "GSLoginNavigationController.h"
#import "MBProgressHUD.h"
#import "GSColorsDeclarationViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface GSUserSettingsViewController () {
    UITextField *currentTextField;
    MBProgressHUD *activityIndicator;
}
@end

@implementation GSUserSettingsViewController
@synthesize updateButtonOutlet,userSeetingFullNameTextField,userSeetingEmailIdTextField,userSeetingPasswordTextField,userSeetingPhoneNumberTextField,userSeetingDateOfBirthTextField,userSeetingTimeOfBirthTextField;
    NSUserDefaults *userSettingDefaults;
    CGFloat _currentKeyboardHeightt = 100.0f;
#pragma mark ViewController Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.updateButtonOutlet.layer setShadowOffset:CGSizeMake(5, 5)];
    [self.updateButtonOutlet.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.updateButtonOutlet.layer setShadowOpacity:0.5];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    userSettingDefaults = [NSUserDefaults standardUserDefaults];
     self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    self.updateButtonOutlet.layer.cornerRadius = 3;
    
   
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        activityIndicator = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
        activityIndicator.label.text = @"Retrieve Data";
    });
    
    NSString *urlAddress = @"http://150.129.180.38:8080/SignaturApp_webservices/rest/user_detail/user/";
    NSString *parameters = [NSString stringWithFormat:@"user_id=%@",[userSettingDefaults objectForKey:@"user_id"]];
    [GSWebServicesCalling signInAccountWithUserName:urlAddress :parameters completion:^(id jsonResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator hideAnimated:YES];
        });
        NSError *localError = nil;
        if(jsonResponse == nil){
            NSLog(@"No Internet Connection================");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Internet Conection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            updateButtonOutlet.enabled = NO;
            [alert show];
        } else{
             updateButtonOutlet.enabled = YES;
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error:&localError];
            
            /**
             *  Show full json data after parse using NSJSONSerialization.
             */
            
            for (NSDictionary *data in parsedJSON) {
                NSLog(@"Retrive User Details====================================%@",data);
                dispatch_async(dispatch_get_main_queue(), ^{
                    userSeetingFullNameTextField.text = [data objectForKey:@"name"];
                    userSeetingEmailIdTextField.text = [data objectForKey:@"email_id"];
                    userSeetingPasswordTextField.text = [data objectForKey:@"password"];
                    userSeetingPhoneNumberTextField.text = [data objectForKey:@"phone_no"];
                    userSeetingDateOfBirthTextField.text = [data objectForKey:@"date_of_birth"];
                    userSeetingTimeOfBirthTextField.text = [data objectForKey:@"time_of_birth"];
                });
            }
        }
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Text Field Delegates
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [currentTextField resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField == userSeetingFullNameTextField){
        [userSeetingFullNameTextField resignFirstResponder];
        [userSeetingEmailIdTextField becomeFirstResponder];
    }
    else if(textField == userSeetingEmailIdTextField){
        [userSeetingEmailIdTextField resignFirstResponder];
        [userSeetingPhoneNumberTextField becomeFirstResponder];
        
    }else if(textField == userSeetingPhoneNumberTextField){
        [userSeetingPhoneNumberTextField resignFirstResponder];
        [userSeetingPasswordTextField becomeFirstResponder];
        
    }else if(textField == userSeetingPasswordTextField){
        [userSeetingPasswordTextField resignFirstResponder];
        [userSeetingDateOfBirthTextField becomeFirstResponder];
        
    }else if(textField == userSeetingDateOfBirthTextField){
        [userSeetingDateOfBirthTextField resignFirstResponder];
        [userSeetingTimeOfBirthTextField becomeFirstResponder];
        
    }else if(textField == userSeetingTimeOfBirthTextField){
        [userSeetingTimeOfBirthTextField resignFirstResponder];
         [self userUpdateSendRequestToServer];
        
    }
    return YES;
}
- (void)keyboardWillShow:(NSNotification*)notification {
    if (currentTextField == userSeetingDateOfBirthTextField || currentTextField == userSeetingTimeOfBirthTextField) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setFrame:CGRectMake(0 , -_currentKeyboardHeightt ,self.view.frame.size.width,self.view.frame.size.height)];
        }];
    }
}
- (void)keyboardWillHide:(NSNotification*)notification {
    _currentKeyboardHeightt = 0.0f;
    if (currentTextField == userSeetingDateOfBirthTextField || currentTextField == userSeetingTimeOfBirthTextField) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setFrame:CGRectMake(0 , 55 ,self.view.frame.size.width,self.view.frame.size.height)];
        }];
    } else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setFrame:CGRectMake(0 , 65 ,self.view.frame.size.width,self.view.frame.size.height)];
        }];
    }
}
#pragma mark UISwitch Button Function
- (IBAction)loggedInSwitchValueChanged:(UISwitch *)sender {
    if ([sender isOn]) {
    } else {
       UIStoryboard *tagEditor = [self.storyboard instantiateViewControllerWithIdentifier:@"GSLoginNavigationController"];
        [self presentModalViewController:tagEditor animated:YES];
        [userSettingDefaults removeObjectForKey:@"user_id"];
        NSLog(@"User Log Out Successfully===============================");
    }
    
}
#pragma  mark Update Button Function
- (IBAction)userUpdateButtonClicked:(id)sender {
    [self userUpdateSendRequestToServer];
}
-(void)userUpdateSendRequestToServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        activityIndicator = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        activityIndicator.label.text = @"Updating";
    });
    NSString *urlAddress = @"http://150.129.180.38:8080/SignaturApp_webservices/rest/updateuser/update/";
    NSString *parameters = [NSString stringWithFormat:@"user_id=%@&password=%@&time_of_birth=%@&name=%@&phone_no=%@&date_of_birth=%@&email_id=%@",[userSettingDefaults objectForKey:@"user_id"],userSeetingPasswordTextField.text,userSeetingTimeOfBirthTextField.text,userSeetingFullNameTextField.text,userSeetingPhoneNumberTextField.text,userSeetingDateOfBirthTextField.text,userSeetingEmailIdTextField.text];
    [GSWebServicesCalling signInAccountWithUserName:urlAddress :parameters completion:^(id jsonResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator hideAnimated:YES];
        });
        NSError *localError = nil;
        NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error:&localError];
        /**
         *  Show full json data after parse using NSJSONSerialization.
         */
        for (NSDictionary *data in parsedJSON) {
            NSLog(@"Update User Successfully========================================%@",data);
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator hideAnimated:YES];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Update Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            });
        }
    }];
}
@end
