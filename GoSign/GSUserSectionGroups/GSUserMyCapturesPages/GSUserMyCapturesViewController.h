//
//  GSUserAskQuestionViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 22/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface GSUserMyCapturesViewController : UIViewController  <UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property ( nonatomic, strong ) NSString *signatureMode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *userAskQuestionSegmentButtonOutlet;

@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)userAskQuestionSegmentButton:(id)sender;
@property (nonatomic, retain) AVPlayerViewController *playerViewController;
- (IBAction)userCaptureButtonClicked:(id)sender;

@end
