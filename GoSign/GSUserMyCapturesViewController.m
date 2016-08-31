//
//  GSUserAskQuestionViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 22/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserMyCapturesViewController.h"
#import "GSUserHomeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


@interface GSUserMyCapturesViewController (){
    NSString *captureMode;
    NSString *selectMode;
    NSUserDefaults *askQuestionUserDefaults;
    NSMutableArray *imagesArray;
}
@end

@implementation GSUserMyCapturesViewController
@synthesize signatureMode,userAskQuestionSegmentButtonOutlet,collectionView,playerViewController;
#pragma  mark ViewController Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    imagesArray = [[NSMutableArray alloc] init];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    collectionView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:244.0/255.0];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    askQuestionUserDefaults = [NSUserDefaults standardUserDefaults];
    selectMode = @"Images";
  
#pragma  mark Create GoSign Name Folder
    NSLog(@"UUID==========================================================================%@",[[NSUUID UUID]UUIDString]);
    /**
     * Create GoSign Directory In File Manager for save image and Video which are captures by user from the camera.
     */
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"Directory Path=======================================================================%@",paths);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"GoSign"];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])    //Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error]) {
            NSLog(@"Create directory error:======================================================== %@", error);
        } else {
            NSLog(@"Directory Create Successfully===============================");
        }
    }
    
    /**
     *  Create Image Directory In File Manager for save Image which are captures by user from the camera.
     *
     *  @param NSDocumentDirectory Documents Path
     *
     *
     */
    NSString *imageDirectoryCreateInFileManager = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"GoSign/Images"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:imageDirectoryCreateInFileManager])
        [[NSFileManager defaultManager] createDirectoryAtPath:imageDirectoryCreateInFileManager withIntermediateDirectories:NO attributes:nil error:&error];
    /**
     *
     *
     *Create Video Directory In File Manager for save Video which are captures by user from the camera.
     *
     *
     */
    NSString *videoDirectoryCreateInFileManager = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"GoSign/Video"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoDirectoryCreateInFileManager])
        [[NSFileManager defaultManager] createDirectoryAtPath:videoDirectoryCreateInFileManager withIntermediateDirectories:NO attributes:nil error:&error];
    
   // [self getImagesFromFileManager];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)  viewWillAppear:(BOOL)animated {
    if([selectMode isEqualToString:@"Images"]){
        [self getImagesFromFileManager];
    }else {
        [self getVideosFromFileManager];
    }
    
}

-(void)getImagesFromFileManager {
    [imagesArray removeAllObjects];
    [collectionView reloadData];
    NSString *pathh;
    NSArray *pathss = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    pathh = [[pathss objectAtIndex:0] stringByAppendingPathComponent:@"GoSign/Images"];
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:pathh];
    NSString *documentsSubpath;
    while (documentsSubpath = [direnum nextObject])
    {
        NSString *doc = [NSString stringWithFormat:@"/%@",documentsSubpath];
        NSString *finalPath = [[@"" stringByAppendingString:pathh]stringByAppendingString:doc];
        NSLog(@"Final Path of Images Files===================================%@",finalPath);
        dispatch_async(dispatch_get_main_queue(), ^{
            [imagesArray addObject:finalPath];
            [collectionView reloadData];
        });
    }
}
-(void)getVideosFromFileManager {
    [imagesArray removeAllObjects];
    [collectionView reloadData];
    NSString *pathh;
    NSArray *pathss = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    pathh = [[pathss objectAtIndex:0] stringByAppendingPathComponent:@"GoSign/Video/"];
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:pathh];
    NSString *documentsSubpath;
    while (documentsSubpath = [direnum nextObject])
    {
        NSString *doc = [NSString stringWithFormat:@"/%@",documentsSubpath];
        NSString *finalPath = [[@"" stringByAppendingString:pathh]stringByAppendingString:doc];
        NSLog(@"Final Path of Video Files===================================%@",finalPath);
        dispatch_async(dispatch_get_main_queue(), ^{
            [imagesArray addObject:finalPath];
            [collectionView reloadData];
        });
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"ReDesign Button Clicked!!!");
    }
    else if (buttonIndex == 1) {
        NSLog(@"Modify Button Clicked!!!");
    }
}

- (IBAction)userAskQuestionSegmentButton:(id)sender {
    if (userAskQuestionSegmentButtonOutlet.selectedSegmentIndex == 0) {
        selectMode = @"Images";
        [self getImagesFromFileManager];
    } else if(userAskQuestionSegmentButtonOutlet.selectedSegmentIndex == 1){
        selectMode = @"Video";
        [self getVideosFromFileManager];
    }
}
#pragma mark Capture Images
- (void)CaptureImage {
    captureMode = @"Image";
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    picker.showsCameraControls = YES;
    [self presentViewController:picker animated:YES completion:^ {}];

}
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    [picker dismissModalViewControllerAnimated:YES];
    NSError *error;
    
    /**
     Get Date for set image name which is capture by user
     - returns: year-month-day/hour:minute:seconds
     */
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    /**
     *  Get UserId from the localStorage
     */
    NSString *getUserId = [askQuestionUserDefaults objectForKey:@"user_id"];
    /**
     *  Set Date in a String
     */
    NSString *date = [dateFormatter stringFromDate:[NSDate date]];
    /**
     *  Concatenate UserId + Date
     */
    // UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if([captureMode isEqualToString:@"Image"]) {
        NSLog(@"Capture Mode==========================================%@",captureMode);
        UIImage *imageNameCaptureByCamera = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        // self.captimage.image= imageNameCaptureByCamera;
        /**
         *  Folder Name in File manager
         *
         *  @param NSDocumentDirectory Document Path
         *
         */
        NSString *fileManagerPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"GoSign/Images"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:fileManagerPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:fileManagerPath withIntermediateDirectories:NO attributes:nil error:&error];
        NSMutableString *imageName = [NSMutableString stringWithFormat:@"%@%@%@",getUserId,date,@".png"];
        NSLog(@"ImageName=======================%@",imageName);
        NSString *fileName = [fileManagerPath stringByAppendingFormat:@"/%@",imageName];
        NSLog(@"File Name Which is store to FileManager========================%@",fileName);
        NSData *data = UIImageJPEGRepresentation(imageNameCaptureByCamera, 1.0);
        [data writeToFile:fileName atomically:YES];
        
    } else if ([captureMode isEqualToString:@"Video"]) {
        NSURL *chosenMovie = [info objectForKey:UIImagePickerControllerMediaURL];
        NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSMutableString *imageName = [NSMutableString stringWithFormat:@"GoSign/Video/%@%@%@",getUserId,date,@".mp4"];
        documentsURL = [documentsURL URLByAppendingPathComponent:imageName];
        NSURL *fileURL = documentsURL;
        NSData *movieData = [NSData dataWithContentsOfURL:chosenMovie];
        [movieData writeToURL:fileURL atomically:YES];
        UISaveVideoAtPathToSavedPhotosAlbum([chosenMovie path], nil, nil, nil);
    }
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)captureVideoButtonClicked {
    captureMode = @"Video";
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [self presentViewController:picker animated:YES completion:NULL];
}
#pragma mark Collection View Delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [imagesArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    if([selectMode isEqualToString:@"Images"]){
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imagesArray objectAtIndex:indexPath.row]]];
    } else{
        NSURL *videoURL = [NSURL fileURLWithPath:[imagesArray objectAtIndex:indexPath.row]];
        MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        UIImage *thumbnail = [player thumbnailImageAtTime:1 timeOption:MPMovieTimeOptionNearestKeyFrame];
        NSData *imgData = UIImagePNGRepresentation(thumbnail);
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imgData]];
        cell.tag = indexPath.row;
        UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVideo:)];
        tapped.numberOfTapsRequired = 1;
        [cell addGestureRecognizer:tapped];
    }
    return cell;
}

-(void)playVideo :(id) sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSURL *streamURL = [NSURL fileURLWithPath:[imagesArray objectAtIndex:gesture.view.tag]];
    MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:streamURL] ;
    
    // Remove the movie player view controller from the "playback did finish" notification observers
    [[NSNotificationCenter defaultCenter] removeObserver:playerVC
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:playerVC.moviePlayer];
    
    // Register this class as an observer instead
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:playerVC.moviePlayer];
    
    // Set the modal transition style of your choice
    playerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    // Present the movie player view controller
    [self presentModalViewController:playerVC animated:YES];
    
    // Start playback
    [playerVC.moviePlayer prepareToPlay];
    [playerVC.moviePlayer play];
    
}
- (void)movieFinishedCallback:(NSNotification*)aNotification
{
    // Obtain the reason why the movie playback finished
    NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    // Dismiss the view controller ONLY when the reason is not "playback ended"
    if ([finishReason intValue] != MPMovieFinishReasonPlaybackEnded)
    {
        MPMoviePlayerController *moviePlayer = [aNotification object];
        
        // Remove this class from the observers
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:moviePlayer];
        
        // Dismiss the view controller
        [self dismissModalViewControllerAnimated:YES];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}
- (IBAction)userCaptureButtonClicked:(id)sender {
    if([selectMode isEqualToString:@"Images"]){
        [self CaptureImage];
    }else {
        [self captureVideoButtonClicked];
    }
}
@end
