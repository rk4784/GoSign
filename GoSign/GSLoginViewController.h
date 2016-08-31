//
//  GSLoginViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 20/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSPageContentViewController.h"
@interface GSLoginViewController : UIViewController <UIPageViewControllerDataSource,UITextFieldDelegate>
    @property (weak, nonatomic) IBOutlet UIImageView *loginPageBackgroundImage;
    @property (weak, nonatomic) IBOutlet UIButton *loginButtonOutlet;
    @property (weak, nonatomic) IBOutlet UITextField *loginPageEmailTextField;
    @property (weak, nonatomic) IBOutlet UITextField *loginPagePasswordTextField;
    @property (strong, nonatomic) UIPageViewController *pageViewController;
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginPageActivityIndicator;
    @property (nonatomic,strong) NSArray *pageTitles;
- (IBAction)forgetPasswordButtonClicked:(id)sender;
    @property (nonatomic,strong) NSArray *pageImages;
    - (IBAction)loginButtonClicked:(id)sender;
    - (GSPageContentViewController *)viewControllerAtIndex:(NSUInteger)index;
    /**
     *  send request to server on login button clicked
     */
    -(void)sendRequestToServerForLogin;
@end
