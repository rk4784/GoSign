//
//  GSForgetPasswordViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 10/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSForgetPasswordViewController.h"
#import "GSWebServicesCalling.h"

@interface GSForgetPasswordViewController (){
      UITextField *currentTextField;
}

@end

@implementation GSForgetPasswordViewController
@synthesize forgetPasswordBackgroundImage,forgotPasswordLabel,enterEmailLabel,forgotPasswordButtonOutlet,forgotPasswordEmailTextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    forgotPasswordButtonOutlet.enabled = NO;
    forgotPasswordLabel.numberOfLines = 0;
     enterEmailLabel.numberOfLines = 0;
   NSString *forgetPasswordString = @"Forgot your\nPassword?";
    forgotPasswordLabel.text = forgetPasswordString;
     NSString *enterEmailString = @"Enter your email address and we'll\nsend you a link to reset your password.";
    enterEmailLabel.text = enterEmailString;
    [self.forgotPasswordButtonOutlet.layer setShadowOffset:CGSizeMake(5, 5)];
    [self.forgotPasswordButtonOutlet.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.forgotPasswordButtonOutlet.layer setShadowOpacity:0.5];
    forgotPasswordButtonOutlet.layer.cornerRadius = 3;
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.forgetPasswordBackgroundImage.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.forgetPasswordBackgroundImage addSubview:blurEffectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [currentTextField resignFirstResponder];
    if(forgotPasswordEmailTextField.text && forgotPasswordEmailTextField.text.length < 5){
        forgotPasswordButtonOutlet.enabled = NO;
    }else{
        forgotPasswordButtonOutlet.enabled = YES;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self sendLink];
    return YES;
}
-(void) sendLink {
    NSString *urlAddress = @"http://150.129.180.38:8080/SignaturApp_webservices/rest/forget/password";
    NSString *parameters = [NSString stringWithFormat:@"username=%@",forgotPasswordEmailTextField.text];
    [GSWebServicesCalling signInAccountWithUserName:urlAddress :parameters completion:^(id jsonResponse, NSError *error) {
        //  NSString *requestReply = [[NSString alloc] initWithData:jsonResponse encoding:NSASCIIStringEncoding];
        NSError *localError = nil;
        /**
         *  Store data which are get from the server
         */
        if (jsonResponse != nil) {
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error:&localError];
           // NSLog(@"%@",parsedJSON);
            /**
             *  Show full json data after parse using NSJSONSerialization.
             */
            for (NSDictionary *data in parsedJSON) {
                NSLog(@"%@",data);
                NSString *getResult = [NSString stringWithFormat:@"%@",data[@"result"]];
                NSString *finalResult = getResult.capitalizedString;
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:finalResult delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                });
            }
        }
    }];
   
}
- (IBAction)sendLinkButtonClicked:(id)sender {
    [self sendLink];
}
@end
