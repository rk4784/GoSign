//
//  GSSignUpViewController.m
//  GoSign
//
//  Created by Rahul Yadav Software Engineer at Yodlee on 20/04/16.
//  Copyright © 2016 Rahul Yadav Software Engineer at Yodlee. All rights reserved.
//

#import "GSSignUpViewController.h"
#import "GSColorsDeclarationViewController.h"
#import "GSWebServicesCalling.h"
#import "MBProgressHUD.h"
#import "GSSignUpTimeFileChooserViewController.h"
@interface GSSignUpViewController (){
    NSUserDefaults *signupUserDefaults;
    /**
     *  Selected TextField
     */
    UITextField *currentTextField;
    /**
     *  Check user gender it set when user click male or female button click
     */
    NSString *userGenderCheck;
    MBProgressHUD *activityIndicator;
}
@end

@implementation GSSignUpViewController
/**
 *  A Background image set in storyboard for est blur effect in view.
 */
@synthesize signUpPageBackgroundImage;
/**
 *  Signup button outlet set for designing e.g., corner radious, and shadow.
 */
@synthesize signUpButtonOutlet;
/**
 *  Male radio button function.
 */
@synthesize maleButtonOutlet;
/**
 *  Female radion button functin.
 */
@synthesize femaleButtonOutlet;
/**
 *  Picker view for set Time and Date in DOB and TOB.
 */

@synthesize datePickerOutlet;
/**
 *  All textfields use in form for signup.
 */
@synthesize fullNameTextField,emailIdTextField,passwordTextField,PhoneNumberTextField,dateOfBirthTextField,TimeOfBirthTextField;
/**
 *  Set Default keyboard height for moving view to upward.
 */
 CGFloat _currentKeyboardHeighttt = 100.0f;
#pragma  mark Life Cycle of ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    signupUserDefaults = [NSUserDefaults standardUserDefaults];
    datePickerOutlet.hidden = YES;
    datePickerOutlet.backgroundColor = [UIColor whiteColor];
    
    self.signUpButtonOutlet.layer.cornerRadius = 3;
    self.signUpPageBackgroundImage.hidden = YES;
    [self.signUpButtonOutlet.layer setShadowOffset:CGSizeMake(5, 5)];
    [self.signUpButtonOutlet.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.signUpButtonOutlet.layer setShadowOpacity:0.5];
    
    [maleButtonOutlet setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [femaleButtonOutlet setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
}

-(void) viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIBarButtonItem *changeTitleOfBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:changeTitleOfBackButton];

}
#pragma  mark Call function on Touch anywhere to view.
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /**
     *  Use for hide keyboard user can touch anywhere in view.
     */
    [currentTextField resignFirstResponder];
    /**
     *   hide datepicker.
     */
    datePickerOutlet.hidden = YES;
}
#pragma mark DatePicker value changed
- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    /**
     *  show dates in datepicker if user click on dateofbirth field.
     */
    if(currentTextField == dateOfBirthTextField){
        self.dateOfBirthTextField.text = [NSDateFormatter localizedStringFromDate:[datePickerOutlet date] dateStyle:kCFDateFormatterShortStyle timeStyle:kCFDateFormatterNoStyle];
    }
    /**
     *show Time in datepicker if user click on timeofbirth field.
     */
    else{
        self.TimeOfBirthTextField.text =  [NSDateFormatter localizedStringFromDate:[datePickerOutlet date] dateStyle:kCFDateFormatterNoStyle timeStyle:kCFDateFormatterShortStyle];
    }
}
#pragma  mark TextField Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
    if(textField == dateOfBirthTextField){
        [currentTextField resignFirstResponder];
        datePickerOutlet.datePickerMode = UIDatePickerModeDate;
         datePickerOutlet.hidden = NO;
    }
    else if (textField == TimeOfBirthTextField){
         [currentTextField resignFirstResponder];
        datePickerOutlet.datePickerMode = UIDatePickerModeTime;
         datePickerOutlet.hidden = NO;
    }
    else {
        datePickerOutlet.hidden = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == fullNameTextField){
        [fullNameTextField resignFirstResponder];
        [emailIdTextField becomeFirstResponder];
    }
    else if(textField == emailIdTextField){
        [emailIdTextField resignFirstResponder];
        [PhoneNumberTextField becomeFirstResponder];
        
    }else if(textField == PhoneNumberTextField){
        [PhoneNumberTextField resignFirstResponder];
        [passwordTextField becomeFirstResponder];
        
    }else if(textField == passwordTextField){
        [passwordTextField resignFirstResponder];
        [dateOfBirthTextField becomeFirstResponder];
        
    }else if(textField == dateOfBirthTextField){
        [dateOfBirthTextField resignFirstResponder];
        [TimeOfBirthTextField becomeFirstResponder];
       
        
    }else if(textField == TimeOfBirthTextField){
        
    }
    return  YES;
}
#pragma  mark Keyboard Delegates Function.
- (void)keyboardWillShow:(NSNotification*)notification {
    if (currentTextField == dateOfBirthTextField || currentTextField == TimeOfBirthTextField) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setFrame:CGRectMake(0 , -_currentKeyboardHeighttt ,self.view.frame.size.width,self.view.frame.size.height)];
        }];
    }
}
- (void)keyboardWillHide:(NSNotification*)notification {
    _currentKeyboardHeighttt = 0.0f;
    if (currentTextField == dateOfBirthTextField || currentTextField == TimeOfBirthTextField) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setFrame:CGRectMake(0 , 65 ,self.view.frame.size.width,self.view.frame.size.height)];
        }];
    } else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setFrame:CGRectMake(0 , 65 ,self.view.frame.size.width,self.view.frame.size.height)];
        }];
    }
}
#pragma mark Functin call on buttons clicked
- (IBAction)maleButtonClicked:(id)sender {
    userGenderCheck = @"Male";
    [maleButtonOutlet setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    [femaleButtonOutlet setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
}

- (IBAction)femaleButtonClicked:(id)sender {
    userGenderCheck = @"Female";
    [maleButtonOutlet setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [femaleButtonOutlet setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
}

- (IBAction)signUpButtonClicked:(id)sender {
    [self sendRequestToServerForSignup];
}
/**
 *  send request to server for signup a user and reader.
 */
-(void) sendRequestToServerForSignup{
    dispatch_async(dispatch_get_main_queue(), ^{
        activityIndicator = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
        activityIndicator.label.text = @"Loading";
    });
    /**
     *  url address.
     */
    NSString *urlAddress = @"http://150.129.180.38:8080/SignaturApp_webservices/rest/signuser/signup/";
    /**
     *  parameters which is send to server.
     */
    NSString *parameters = [NSString stringWithFormat:@"name=%@&email_id=%@&phone_no=%@&password=%@&sex=%@&date_of_birth=%@&time_of_birth=%@",fullNameTextField.text,emailIdTextField.text,PhoneNumberTextField.text,passwordTextField.text,userGenderCheck,dateOfBirthTextField.text,TimeOfBirthTextField.text];
    /**
     *  A common webservice function use for send request to server GSWebServicesCalling is FileName .
     *
     *  @param jsonResponse Return the Result. if data came from server then it show data otherwise it show nil.
     *  @param error  if request not successfully hit then it return a error.
     *
     *  @return JSON return
     */
    [GSWebServicesCalling signInAccountWithUserName:urlAddress :parameters completion:^(id jsonResponse, NSError *error) {
        NSError *localError = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator hideAnimated:YES];
        });
        /**
         *  If data not come from the server then json data is nil.
         */
        if(jsonResponse == nil){
            NSLog(@"No Internet Connection================");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Internet Conection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        } else{
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error:&localError];
            
            /**
             *  Show full json data after parse using NSJSONSerialization.
             */
            
            for (NSDictionary *data in parsedJSON) {
                NSLog(@"Retrive User Details====================================%@",data);
                /**
                 *  If email already exists
                 */
                if(data[@"result"]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // [activityIndicator hideAnimated:YES];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Email Already Exists" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alert show];
                    });
                }else{
                    NSString *user_id = [data objectForKey:@"user_id"];
                    [signupUserDefaults setObject:user_id forKey:@"user_id"];
                    NSArray *_planlist = [data valueForKeyPath:@"planlist"];
                    for(NSDictionary *planlist in _planlist){
                        NSArray *_plandetail = planlist[@"plandetail"];
                        for (NSDictionary *plandetail in _plandetail) {
                            NSString *user_plan_id = plandetail[@"user_plan_id"];
                            [signupUserDefaults setObject:user_plan_id forKey:@"user_plan_id"];
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                        GSSignUpTimeFileChooserViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"GSSignUpTimeFileChooserViewController"];
                        [self.navigationController pushViewController:controller animated:YES];
                    });
                }
            }
        }
    }];
}
@end
