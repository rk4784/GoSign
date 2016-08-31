//
//  GSUserMyAnalysisDetailsShowViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 09/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserMyAnalysisDetailsShowViewController.h"
#import "GSWebServicesCalling.h"
#import "MBProgressHUD.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


@interface GSUserMyAnalysisDetailsShowViewController (){
    NSUserDefaults *userMyAnalysisDefaults;
     MBProgressHUD *activityIndicator;
}

@end

@implementation GSUserMyAnalysisDetailsShowViewController
@synthesize questionId,myAnalysisQuestionImage,myAnalysisQuestionVideo,myAnalysisFullQuestionShowLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    myAnalysisFullQuestionShowLabel.numberOfLines = 0;
    userMyAnalysisDefaults = [NSUserDefaults standardUserDefaults];
    [self getQuestionDetails];
    activityIndicator = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    activityIndicator.label.text = @"Loading";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)getQuestionDetails {
    NSString *urlAddress = @"http://150.129.180.38:8080/SignaturApp_webservices/rest/detail_of_question/for_user/";
    NSString *parameters = [NSString stringWithFormat:@"user_id=%@&question_id=%@",[userMyAnalysisDefaults objectForKey:@"user_id"],questionId];
    [GSWebServicesCalling signInAccountWithUserName:urlAddress :parameters completion:^(id jsonResponse, NSError *error) {
        NSError *localError = nil;
        if (jsonResponse != nil) {
           
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error:&localError];
            /**
             *  Show full json data after parse using NSJSONSerialization.
             */
            
            for (NSDictionary *data in parsedJSON) {
                NSLog(@"%@",data);
                
                NSString *question = [data objectForKey:@"question"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [activityIndicator hideAnimated:YES];
                    myAnalysisFullQuestionShowLabel.text = question;
                   // myAnalysisFullQuestionShowLabel.adjustsFontSizeToFitWidth = YES;
                    
                    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:data[@"image"]]];
                    myAnalysisQuestionImage.image = [UIImage imageWithData:imageData];
                    NSURL *videoURL = [NSURL URLWithString:@"http://150.129.180.38/signature/142/tr3doUm05iaP.mp4"];
//                    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
//                    UIImage *thumbnail = [player thumbnailImageAtTime:1 timeOption:MPMovieTimeOptionNearestKeyFrame];
//                    NSData *imgData = UIImagePNGRepresentation(thumbnail);
//                    myAnalysisQuestionVideo.image = [UIImage imageWithData:imgData];
                });
            }
        } else {
           
        }
    }];
}
@end
