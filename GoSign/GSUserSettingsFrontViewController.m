//
//  GSUserSettingsFrontViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 11/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserSettingsFrontViewController.h"
#import "GSUserSettingsViewController.h"
#import "GSLoginNavigationController.h"
#import "GSUserChangePlanViewController.h"
#import "GSUserTransactionHistoryViewController.h"

@interface GSUserSettingsFrontViewController (){
    NSUserDefaults *userSettingDefaults;
}

@end

@implementation GSUserSettingsFrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userSettingDefaults = [NSUserDefaults standardUserDefaults];
    accordion = [[AccordionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    [self.view addSubview:accordion];
   self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    
    UIButton *header1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    [header1 setTitle:@"     Profile" forState:UIControlStateNormal];
    [header1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    header1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    header1.backgroundColor = [UIColor whiteColor];
    header1.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header1.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header1.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView1.center = CGPointMake(25, header1.frame.size.height / 2);
    imageView1.image = [UIImage imageNamed:@"GSRightArrow.png"];
    [header1 addSubview:imageView1];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [accordion addHeader:header1 withView:view1];
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;;
    border.frame = CGRectMake(0, header1.frame.size.height - borderWidth, header1.frame.size.width, header1.frame.size.height);
    border.borderWidth = borderWidth;
    [header1.layer addSublayer:border];
    UITapGestureRecognizer *profilePageShow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profilePageShow:)];
    [header1 addGestureRecognizer:profilePageShow];
    
    
    UIButton *header2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    [header2 setTitle:@"     Payment Plans" forState:UIControlStateNormal];
    [header2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    header2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    header2.backgroundColor = [UIColor whiteColor];
    header2.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header2.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header2.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView2.center = CGPointMake(25, header2.frame.size.height / 2);
    imageView2.image = [UIImage imageNamed:@"GSRightArrow.png"];
    [header2 addSubview:imageView2];
    
    
    
    
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 150)];
     view2.backgroundColor = [UIColor colorWithRed:0.102 green:0.37 blue:0.612 alpha:1.000];
    
    UILabel *currentPlanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.view.layer.bounds.size.width, 50)];
    currentPlanLabel.backgroundColor = [UIColor clearColor];
    currentPlanLabel.text = @"     Current Plan";
    currentPlanLabel.textColor = [UIColor whiteColor];
    CALayer *currentPlanLabelLayer = [CALayer layer];
    CGFloat currentPlanLabelLayerBorderWidth = 1;
    currentPlanLabelLayer.borderColor = [UIColor colorWithRed:0.102 green:0.37 blue:0.712 alpha:1.000].CGColor;
    currentPlanLabelLayer.frame = CGRectMake(0, currentPlanLabel.frame.size.height - currentPlanLabelLayerBorderWidth, currentPlanLabel.frame.size.width, 1);
    currentPlanLabelLayer.borderWidth = currentPlanLabelLayerBorderWidth;
    [currentPlanLabel.layer addSublayer:currentPlanLabelLayer];
    [view2 addSubview:currentPlanLabel];
    
    
    
    
    
    
    
    UIButton *changePlanButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50,self.view.layer.bounds.size.width, 50)];
    [changePlanButton setTitle:@"     Change Plan" forState:UIControlStateNormal];
    [changePlanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changePlanButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    changePlanButton.backgroundColor = [UIColor clearColor];
    changePlanButton.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    changePlanButton.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    changePlanButton.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    UIImageView *changePlanButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    changePlanButtonImage.center = CGPointMake(25, changePlanButton.frame.size.height / 2);
    changePlanButtonImage.image = [UIImage imageNamed:@"GSRightArrowBlack.png"];
    [changePlanButton addSubview:changePlanButtonImage];
    CALayer *changePlanButtonLayerBorder = [CALayer layer];
    CGFloat changePlanButtonLayerBorderWidth = 1;
    changePlanButtonLayerBorder.borderColor = [UIColor colorWithRed:0.102 green:0.37 blue:0.712 alpha:1.000].CGColor;
    changePlanButtonLayerBorder.frame = CGRectMake(0, changePlanButton.frame.size.height - changePlanButtonLayerBorderWidth, changePlanButton.frame.size.width, 1);
    changePlanButtonLayerBorder.borderWidth = changePlanButtonLayerBorderWidth;
    [changePlanButton.layer addSublayer:changePlanButtonLayerBorder];
    [view2 addSubview:changePlanButton];
    UITapGestureRecognizer *changePlanButtonClicked = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePlans:)];
    [changePlanButton addGestureRecognizer:changePlanButtonClicked];

    
    
    
    
    
    
    UILabel *noOfQuestionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100,self.view.layer.bounds.size.width, 50)];
    noOfQuestionLabel.backgroundColor = [UIColor clearColor];
    noOfQuestionLabel.text = @"     No. of Questions";
    noOfQuestionLabel.textColor = [UIColor whiteColor];
    [view2 addSubview:noOfQuestionLabel];
    CALayer *noOfQuestionLabelLayer = [CALayer layer];
    CGFloat noOfQuestionLabelLayerBorderWidth = 1;
    noOfQuestionLabelLayer.borderColor = [UIColor colorWithRed:0.102 green:0.37 blue:0.712 alpha:1.000].CGColor;;
    noOfQuestionLabelLayer.frame = CGRectMake(0, noOfQuestionLabel.frame.size.height - noOfQuestionLabelLayerBorderWidth, noOfQuestionLabel.frame.size.width, 1);
    noOfQuestionLabelLayer.borderWidth = noOfQuestionLabelLayerBorderWidth;
    [noOfQuestionLabel.layer addSublayer:noOfQuestionLabelLayer];

    
   
    
    
    
    [accordion addHeader:header2 withView:view2];
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 1;
    border2.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    border2.frame = CGRectMake(0, header2.frame.size.height - borderWidth2, header2.frame.size.width, 1);
    border2.borderWidth = borderWidth2;
    [header2.layer addSublayer:border2];
   
    
    UIButton *header3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    [header3 setTitle:@"     Transaction History" forState:UIControlStateNormal];
    [header3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    header3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    header3.backgroundColor = [UIColor whiteColor];
    header3.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header3.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header3.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView3.center = CGPointMake(25, header3.frame.size.height / 2);
    imageView3.image = [UIImage imageNamed:@"GSRightArrow.png"];
    [header3 addSubview:imageView3];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [accordion addHeader:header3 withView:view3];
    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 1;
    border3.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;;
    border3.frame = CGRectMake(0, header2.frame.size.height - borderWidth3, header3.frame.size.width, 1);
    border3.borderWidth = borderWidth3;
    [header3.layer addSublayer:border3];
    UITapGestureRecognizer *transactionHistoryPageShow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transactionHistoryPageShow:)];
    [header3 addGestureRecognizer:transactionHistoryPageShow];
    
    
    
    
    
    UIButton *header4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    [header4 setTitle:@"     Notification" forState:UIControlStateNormal];
    [header4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    header4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    header4.backgroundColor = [UIColor whiteColor];
    header4.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header4.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header4.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    UISwitch *notificationSwitch = [[UISwitch alloc] initWithFrame: CGRectMake(0, 0, 40, 40)];
    notificationSwitch.center = CGPointMake(35, header3.frame.size.height / 2);
    notificationSwitch.transform = CGAffineTransformRotate(self.view.transform, (M_PI * 180 / 180));
    [notificationSwitch addTarget: self action: @selector(notificationSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    [notificationSwitch setOn:NO];
    [header4 addSubview:notificationSwitch];
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [accordion addHeader:header4 withView:view4];
    CALayer *border4 = [CALayer layer];
    CGFloat borderWidth4 = 1;
    border4.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;;
    border4.frame = CGRectMake(0, header4.frame.size.height - borderWidth4, header4.frame.size.width, 1);
    border4.borderWidth = borderWidth4;
    [header4.layer addSublayer:border4];
    
    
    
    
    
    
    
    UIButton *header5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    [header5 setTitle:@"     Logged-In" forState:UIControlStateNormal];
    [header5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    header5.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    header5.backgroundColor = [UIColor whiteColor];
    header5.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header5.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    header5.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    UISwitch *logoutSwitch = [[UISwitch alloc] initWithFrame: CGRectMake(0, 0, 40, 40)];
    logoutSwitch.center = CGPointMake(35, header5.frame.size.height / 2);
    logoutSwitch.transform = CGAffineTransformRotate(self.view.transform, (M_PI * 180 / 180));
    [logoutSwitch addTarget: self action: @selector(loggedInSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    [logoutSwitch setOn:YES];
    [header5 addSubview:logoutSwitch];
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [accordion addHeader:header5 withView:view5];
    CALayer *border5 = [CALayer layer];
    CGFloat borderWidth5 = 1;
    border5.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;;
    border5.frame = CGRectMake(0, header5.frame.size.height - borderWidth5, header5.frame.size.width, 1);
    border5.borderWidth = borderWidth5;
    [header5.layer addSublayer:border5];
    
    
    
    
    
    [accordion setNeedsLayout];
    [accordion setAllowsMultipleSelection:YES];
    
    [accordion setAllowsEmptySelection:YES];
}
- (IBAction) notificationSwitchValueChange: (id) sender {
    UISwitch *onoff = (UISwitch *) sender;
    NSLog(@"%@", onoff.on ? @"On" : @"Off");
}
- (IBAction) loggedInSwitchValueChange: (id) sender {
    if ([sender isOn]) {
    } else {
        UIStoryboard *tagEditor = [self.storyboard instantiateViewControllerWithIdentifier:@"GSLoginNavigationController"];
        [self presentModalViewController:tagEditor animated:YES];
        [userSettingDefaults removeObjectForKey:@"user_id"];
        NSLog(@"User Log Out Successfully===============================");
    }
}
- (void)removeSecondRow {
    [accordion removeHeaderAtIndex:1];
}
-(void)profilePageShow: (UIGestureRecognizer *) gesture{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    GSUserSettingsViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"GSUserSettingsViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)changePlans: (UIGestureRecognizer *) gesture{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    GSUserChangePlanViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"GSUserChangePlanViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)transactionHistoryPageShow: (UIGestureRecognizer *) gesture{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    GSUserTransactionHistoryViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"GSUserTransactionHistoryViewController"];
    [self.navigationController pushViewController:controller animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *changeTitleOfBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:changeTitleOfBackButton];
}


@end
