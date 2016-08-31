//
//  GSLoginViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 20/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSLoginViewController.h"
#import "GSPageContentViewController.h"
#import "GSWebServicesCalling.h"
#import "GSUserTabBarController.h"
#import "MBProgressHUD.h"
@interface GSLoginViewController (){
    UITextField *currentTextField;
      MBProgressHUD *activityIndicator;
}
@end

@implementation GSLoginViewController
@synthesize loginPagePasswordTextField,loginPageActivityIndicator,loginPageEmailTextField,loginButtonOutlet,loginPageBackgroundImage;
CGFloat _currentKeyboardHeight = 0.0f;
NSUserDefaults *defaults;
#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginButtonOutlet.layer setShadowOffset:CGSizeMake(5, 5)];
    [self.loginButtonOutlet.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.loginButtonOutlet.layer setShadowOpacity:0.5];
   // loginButtonOutlet.enabled = NO;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    self.loginPagePasswordTextField.delegate = self;
    self.loginPageEmailTextField.delegate = self;
    self.loginButtonOutlet.layer.cornerRadius = 3;
    self.loginPageBackgroundImage.image = [UIImage imageNamed:@"GSBackgroundImage.jpg"];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.loginPageBackgroundImage.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.loginPageBackgroundImage addSubview:blurEffectView];
    
    _pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip"];
    _pageImages = @[@"GSSlideImage1.jpg", @"GSSlideImage2.jpg", @"GSSlideImage3.jpg"];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    GSPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 1.5);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    self.loginPagePasswordTextField.text = @"qwertyui";
    self.loginPageEmailTextField.text = @"aksp@gmail.com";
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillAppear:(BOOL)animated {
    UIBarButtonItem *changeTitleOfBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:changeTitleOfBackButton];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // return  YES;
}
#pragma mark - Page View Controller Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((GSPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((GSPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (GSPageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    GSPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GSPageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    return pageContentViewController;
}


#pragma mark - Text field delegates
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField == loginPageEmailTextField){
        [loginPageEmailTextField resignFirstResponder];
        [loginPagePasswordTextField becomeFirstResponder];
    }
    else if(textField == loginPagePasswordTextField){
        [loginPagePasswordTextField resignFirstResponder];
        [self sendRequestToServerForLogin];
    }
    if (loginPageEmailTextField.text.length <3 ) {
        loginButtonOutlet.enabled = NO;
    } else if(loginPagePasswordTextField.text.length <3){
         loginButtonOutlet.enabled = NO;
    }else {
        loginButtonOutlet.enabled = YES;
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
    if (loginPageEmailTextField.text.length <3 ) {
        loginButtonOutlet.enabled = NO;
    } else if(loginPagePasswordTextField.text.length <3){
        loginButtonOutlet.enabled = NO;
    }else {
        loginButtonOutlet.enabled = YES;
    }
}
#pragma  mark Call function on Touch anywhere to view.
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /**
     *  Use for hide keyboard user can touch anywhere in view.
     */
    [currentTextField resignFirstResponder];
}
#pragma mark - Move TextField to Upward
- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //CGFloat deltaHeight = kbSize.height - _currentKeyboardHeight;
    _currentKeyboardHeight = kbSize.height;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setFrame:CGRectMake(0 , -_currentKeyboardHeight ,self.view.frame.size.width,self.view.frame.size.height)];
    }];
}
- (void)keyboardWillHide:(NSNotification*)notification {
    _currentKeyboardHeight = 0.0f;
       [UIView animateWithDuration:0.5 animations:^{
        [self.view setFrame:CGRectMake(0 , _currentKeyboardHeight ,self.view.frame.size.width,self.view.frame.size.height)];
    }];
}

#pragma mark - Hide StatusBar
-(BOOL) prefersStatusBarHidden {
    return YES;
}
#pragma mark - User Login Functionality
- (IBAction) loginButtonClicked:(id)sender {
    NSLog(@"Login Button Clicked");
    [loginPageActivityIndicator startAnimating];
    /**
     *  Call Webservice for check user Authentication
     */
    [self sendRequestToServerForLogin];
}

- (IBAction)forgetPasswordButtonClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Forget Password" message:@"Please Enter Your Email-Id" delegate:self cancelButtonTitle:@"Send" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    // [alert show];
}
-(void) sendRequestToServerForLogin {
    dispatch_async(dispatch_get_main_queue(), ^{
        activityIndicator = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        activityIndicator.label.text = @"Loading";
    });
    NSString *urlAddress = @"http://150.129.180.38:8080/SignaturApp_webservices/rest/user/login/";
    NSString *parameters = [NSString stringWithFormat:@"username=%@&password=%@",loginPageEmailTextField.text,loginPagePasswordTextField.text];
    [GSWebServicesCalling signInAccountWithUserName:urlAddress :parameters completion:^(id jsonResponse, NSError *error) {
        //  NSString *requestReply = [[NSString alloc] initWithData:jsonResponse encoding:NSASCIIStringEncoding];
        NSError *localError = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator hideAnimated:YES];
        });
        /**
         *  Store data which are get from the server
         */
        if (jsonResponse != nil) {
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error:&localError];
            /**
             *  Show full json data after parse using NSJSONSerialization.
             */
            for (NSDictionary *data in parsedJSON) {
                NSLog(@"%@",data);
                [defaults setObject:[data objectForKey:@"email_id"] forKey:@"email_id"];
                [defaults setObject:[data objectForKey:@"user_id"] forKey:@"user_id"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                UIStoryboard *tagEditor = [self.storyboard instantiateViewControllerWithIdentifier:@"GSUserTabBarController"];
                [self presentModalViewController:tagEditor animated:YES];
                [loginPageActivityIndicator stopAnimating];
            });
        } else {
            [loginPageActivityIndicator stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Invalid Information" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
@end
