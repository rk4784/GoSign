//
//  GSUserMyAnalysisDetailsShowViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 09/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSUserMyAnalysisDetailsShowViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *myAnalysisFullQuestionShowLabel;

@property (nonatomic,strong) NSString *questionId;
@property (weak, nonatomic) IBOutlet UIImageView *myAnalysisQuestionImage;
@property (weak, nonatomic) IBOutlet UIImageView *myAnalysisQuestionVideo;

@end
