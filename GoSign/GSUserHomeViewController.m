//
//  GSUserHomeViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 21/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserHomeViewController.h"
#import "GSColorsDeclarationViewController.h"
#import "GSUserAskQuestionViewController.h"
#import "GSUserMyCapturesViewController.h"
#import "GSUserAnalysisTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GSWebServicesCalling.h"

@interface GSUserHomeViewController ()

@end

@implementation GSUserHomeViewController
@synthesize mySignatureBackgroundLabel,userHomeMyAnbalysisLabel,userHomeMySignaturelabel,userHomePageBackgroundImage,userHomeRedesignSignatureButtonOutlet,userHomeContactUsButtonOutlet,userHomeModifySignatureButtonOutlet;
NSUserDefaults *userHomeDefaults;

- (void)viewDidLoad {
    [super viewDidLoad];
    userHomeDefaults = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    
    userHomeContactUsButtonOutlet.layer.masksToBounds = YES;
    userHomeModifySignatureButtonOutlet.layer.masksToBounds = YES;
    userHomeRedesignSignatureButtonOutlet.layer.masksToBounds = YES;

    CALayer *UHMModifyButtonLeftBorder = [CALayer layer];
    UHMModifyButtonLeftBorder.borderColor = [[UIColor leftBorderColor] CGColor] ;
    UHMModifyButtonLeftBorder.borderWidth = 5;
    UHMModifyButtonLeftBorder.frame = CGRectMake(0, 0, 5, userHomeModifySignatureButtonOutlet.frame.size.height);
    self.userHomeModifySignatureButtonOutlet.layer.cornerRadius = 5;
    [userHomeModifySignatureButtonOutlet.layer addSublayer:UHMModifyButtonLeftBorder];

    CALayer *UHMRedesignButtonLeftBorder = [CALayer layer];
    UHMRedesignButtonLeftBorder.borderColor = [[UIColor leftBorderColor] CGColor] ;
    UHMRedesignButtonLeftBorder.borderWidth = 5;
    UHMRedesignButtonLeftBorder.frame = CGRectMake(0, 0, 5, userHomeRedesignSignatureButtonOutlet.frame.size.height);
    self.userHomeRedesignSignatureButtonOutlet.layer.cornerRadius = 5;
    [userHomeRedesignSignatureButtonOutlet.layer addSublayer:UHMRedesignButtonLeftBorder];

    CALayer *UHMContactusButtonLeftBorder = [CALayer layer];
    UHMContactusButtonLeftBorder.borderColor = [[UIColor leftBorderColor] CGColor] ;
    UHMContactusButtonLeftBorder.borderWidth = 5;
    UHMContactusButtonLeftBorder.frame = CGRectMake(0, 0, 5, userHomeContactUsButtonOutlet.frame.size.height);
    self.userHomeContactUsButtonOutlet.layer.cornerRadius = 5;
    [userHomeContactUsButtonOutlet.layer addSublayer:UHMContactusButtonLeftBorder];

    CALayer *UHMMySignatureUpBorder = [CALayer layer];
    UHMMySignatureUpBorder.borderColor = [[UIColor leftBorderColor] CGColor] ;
    UHMMySignatureUpBorder.borderWidth = 5;
    UHMMySignatureUpBorder.frame = CGRectMake(0, 0, 5, mySignatureBackgroundLabel.frame.size.height);
    self.mySignatureBackgroundLabel.layer.cornerRadius = 5;
    [mySignatureBackgroundLabel.layer addSublayer:UHMMySignatureUpBorder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem *changeTitleOfBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:changeTitleOfBackButton];
    NSString *urlAddress = @"http://150.129.180.38:8080/SignaturApp_webservices/rest/list/for_user/";
    NSString *parameters = [NSString stringWithFormat:@"user_id=%@",[userHomeDefaults objectForKey:@"user_id"]];
    [GSWebServicesCalling signInAccountWithUserName:urlAddress :parameters completion:^(id jsonResponse, NSError *error) {
        //  NSString *requestReply = [[NSString alloc] initWithData:jsonResponse encoding:NSASCIIStringEncoding];
        NSError *localError = nil;
        if (jsonResponse != nil) {
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error:&localError];
            dispatch_async(dispatch_get_main_queue(), ^{
                [userHomeMyAnbalysisLabel setText:[NSString stringWithFormat:@"%lu",(unsigned long)[parsedJSON count]]];
            });
            
        } else {
           self.userHomeMyAnbalysisLabel.text = @"0";
        }
    }];
    NSString *pathh;
    NSArray *pathss = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    pathh = [[pathss objectAtIndex:0] stringByAppendingPathComponent:@"GoSign/Images"];
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:pathh];
    NSString *documentsSubpath;
    int mySignatureCount = 0;
    while (documentsSubpath = [direnum nextObject])
    {
        mySignatureCount ++;
        
    }
    [userHomeMySignaturelabel setText:[NSString stringWithFormat:@"%d",mySignatureCount]];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ModifySignature"]){
        GSUserAskQuestionViewController *controller = (GSUserAskQuestionViewController *)segue.destinationViewController;
        controller.signatureMode = @"ModifySignature";
    } else if([segue.identifier isEqualToString:@"RedesignSignature"]){
        GSUserAskQuestionViewController *controller = (GSUserAskQuestionViewController *)segue.destinationViewController;
        controller.signatureMode = @"RedesignSignature";
    } else if([segue.identifier isEqualToString:@"ViewSignature"]){
        GSUserMyCapturesViewController *controller = (GSUserMyCapturesViewController *)segue.destinationViewController;
        controller.signatureMode = @"ViewSignature";
    } else if([segue.identifier isEqualToString:@"myAnalysisSegue"]){
        GSUserAnalysisTableViewController *controller = (GSUserAnalysisTableViewController *)segue.destinationViewController;
        controller.signatureMode = @"NoAlert";
    }
}
@end
