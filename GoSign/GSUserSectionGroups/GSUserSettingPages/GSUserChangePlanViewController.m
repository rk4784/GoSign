//
//  GSUserChangePlanViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 11/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserChangePlanViewController.h"
#import "AccordionView.h"


@interface GSUserChangePlanViewController (){
#pragma mark Define All Labels And Buttons
    UIButton *completePredicitionButton;
    UIButton *modifySignatureButton;
    UIButton *reDesignSignatuireButton;
    UILabel *completePredicitionPlanDetailLabel;
    UILabel *modifySignaturePlanDetailsLabel;
    UILabel *redesignSignaturePlanDetailsLabel;
}
@end

@implementation GSUserChangePlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    completePredicitionButton.tag = 0;
    modifySignatureButton.tag = 1;
    reDesignSignatuireButton.tag = 2;
    
   accordion = [[AccordionView alloc] initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height)];
   [self.view addSubview:accordion];
    self.view.backgroundColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1.000];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark Create Accordian
-(void)viewWillAppear:(BOOL)animated{

    
    
    
    
    
    
    
    
    
    
    
    
    
    /**
     *
     *
     *
        Complete Predicition Signature Plans Details.
     *
     *
     *
     */
    completePredicitionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    [completePredicitionButton addTarget:self
                                  action:@selector(completePredicitionPlanButtonClicked:)
                        forControlEvents:UIControlEventTouchUpInside];
    [completePredicitionButton setTitle:@"Complete Predicition" forState:UIControlStateNormal];
    completePredicitionButton.backgroundColor = [UIColor colorWithRed:0.086 green:0.627 blue:0.522 alpha:1.000];
    UIView *completePredicitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 110)];
    completePredicitionView.backgroundColor = [UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1.000];
    completePredicitionPlanDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, 100)];
    completePredicitionPlanDetailLabel.text = @"You can ask about Major Opportunities and Career Grrowth, Wealth, Health, RelationShip. \n\n-> 1 question which included 5 Queries (Per Question).\n-> Analyst will response in Text 7 Audio, But response in Image/Video is optional.";
    completePredicitionPlanDetailLabel.adjustsFontSizeToFitWidth = YES;
    completePredicitionPlanDetailLabel.numberOfLines = 0;
    [completePredicitionButton addSubview:completePredicitionPlanDetailLabel];
    completePredicitionPlanDetailLabel.textColor = [UIColor whiteColor];
    [completePredicitionView addSubview:completePredicitionPlanDetailLabel];
    [accordion addHeader:completePredicitionButton withView:completePredicitionView];
    
    /**
     *
     *
     *
        Modify Signature Plans Details.
     *
     *
     *
     */
    
    modifySignatureButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    [modifySignatureButton addTarget:self
                                  action:@selector(modifySignaturePlanButtonClicked:)
                        forControlEvents:UIControlEventTouchUpInside];
    [modifySignatureButton setTitle:@"Modify Signature      " forState:UIControlStateNormal];
    modifySignatureButton.backgroundColor = [UIColor colorWithRed:0.557 green:0.267 blue:0.678 alpha:1.000];
    
    UIView *modifySignaturePlanDetailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 140)];
    modifySignaturePlanDetailsView.backgroundColor = [UIColor colorWithRed:0.608 green:0.349 blue:0.714 alpha:1.000];
    
    modifySignaturePlanDetailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, 140)];
    modifySignaturePlanDetailsLabel.text = @"User can MODIFY his/her signature and ask multiple queries at a time.\n\n-> 1 question which includes multiple no. of Queries & Aspirations.\n-> 500 pages (PDF) Go Sign Kit for Practice.\n-> Consultation period 30 days.\n-> Analyst will response in TEXT & Audio and IMAGE/Video.";
    modifySignaturePlanDetailsLabel.adjustsFontSizeToFitWidth = YES;
    modifySignaturePlanDetailsLabel.numberOfLines = 0;
    modifySignaturePlanDetailsLabel.textColor = [UIColor whiteColor];
    [modifySignaturePlanDetailsView addSubview:modifySignaturePlanDetailsLabel];
    [accordion addHeader:modifySignatureButton withView:modifySignaturePlanDetailsView];
    
    /**
     *
     *
     *
        rddesign Signature Plans Details.
     *
     *
     *
     */
    
    reDesignSignatuireButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    [reDesignSignatuireButton addTarget:self
                                  action:@selector(redesignSignaturePlanButtonClicked:)
                        forControlEvents:UIControlEventTouchUpInside];
    [reDesignSignatuireButton setTitle:@"Redesign Signature  " forState:UIControlStateNormal];
    reDesignSignatuireButton.backgroundColor = [UIColor colorWithRed:0.827 green:0.329 blue:0.000 alpha:1.000];
    
    UIView *redesignSignaturePlanDetailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 110)];
    redesignSignaturePlanDetailsView.backgroundColor = [UIColor colorWithRed:0.902 green:0.494 blue:0.133 alpha:1.000];
    
    redesignSignaturePlanDetailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, 100)];
    redesignSignaturePlanDetailsLabel.text = @"User will get a complete New Design his/her signature and ask multiple queries for ot.\n\n-> 1 question which includes multiple no. of Queries & Aspiration.\n-> 500 pages (PDF) Go Sign Kit for pratice.";
    redesignSignaturePlanDetailsLabel.adjustsFontSizeToFitWidth = YES;
    redesignSignaturePlanDetailsLabel.numberOfLines = 0;
    redesignSignaturePlanDetailsLabel.textColor = [UIColor whiteColor];
    [redesignSignaturePlanDetailsView addSubview:redesignSignaturePlanDetailsLabel];
    [accordion addHeader:reDesignSignatuireButton withView:redesignSignaturePlanDetailsView];
    
    
    
    [accordion setNeedsLayout];
    [accordion setAllowsMultipleSelection:YES];
    
    [accordion setAllowsEmptySelection:YES];
    [completePredicitionButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    [modifySignatureButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [reDesignSignatuireButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
}
#pragma mark Plans button Clicked functions
-(void)completePredicitionPlanButtonClicked:(id)sender{
    [completePredicitionButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    [modifySignatureButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [reDesignSignatuireButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
}
-(void)modifySignaturePlanButtonClicked:(id)sender{
    [completePredicitionButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [modifySignatureButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    [reDesignSignatuireButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
}
-(void)redesignSignaturePlanButtonClicked:(id)sender{
    [completePredicitionButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [modifySignatureButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [reDesignSignatuireButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
}

@end
