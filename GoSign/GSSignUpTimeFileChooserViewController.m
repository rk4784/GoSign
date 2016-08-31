//
//  GSSignUpTimeFileChooserViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 12/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSSignUpTimeFileChooserViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "GSUserTabBarController.h"

@interface GSSignUpTimeFileChooserViewController ()<UITextFieldDelegate>{
    /**
     * A String use for check user click in which mode e.g., camera or video.
     */
    NSString *captureMode;
    /**
     *  Video url for playing video or create thumbnails.
     */
    NSURL *videoUrl;
    NSUserDefaults *signupFileChooseUserDefaults;
    /**
     *  Store selected textfield name.
     */
    UITextField *currentTextField;
    /**
     *  Selected TextField
     */
    MBProgressHUD *activityIndicator;
}

@end

@implementation GSSignUpTimeFileChooserViewController
/**
 *  Instruction label use for show instruction to user.
 */
@synthesize instructionLabel;
/**
 *  Show image which is capture by user from the camera.
 */
@synthesize addImageShow;
/**
 *  Show thumbnail of video which is record by user.
 */
@synthesize addVideoThumbnailsShow;
/**
 *  Submit button outlet for design button.
 */
@synthesize submitButtonOutlet;
/**
 *  TextField use for user write the text question.
 */
@synthesize textQuestionTextField;
#pragma  mark Life Cycle of ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    signupFileChooseUserDefaults = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    addVideoThumbnailsShow.userInteractionEnabled = YES;
    
    NSString *instruction = @"    You Need to add minimum 10 Signatures.\n Add your Signature By\n Capturing Video OR \n capture your signature image.";
    instructionLabel.numberOfLines = 0;
    instructionLabel.text = instruction;
    instructionLabel.layer.cornerRadius = 0;
    instructionLabel.userInteractionEnabled = YES;
    
    
    
    submitButtonOutlet.layer.cornerRadius = 3;
    [self.submitButtonOutlet.layer setShadowOffset:CGSizeMake(5, 5)];
    [self.submitButtonOutlet.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.submitButtonOutlet.layer setShadowOpacity:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  Add button clicked for capture a video or image.
 *
 *  @param sender self.
 */
#pragma mark Add button clicked functions.
- (IBAction)addButtonClicked:(id)sender {
    UIActionSheet *fileChooseoptions = [[UIActionSheet alloc]initWithTitle:@"Choose Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Video", nil];
    fileChooseoptions.tag = 1;
    [fileChooseoptions showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)fileChooseoptions clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (fileChooseoptions.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    NSLog(@"Camera Choose");
                    [self chooseCamera];
                    break;
                    case 1:
                    NSLog(@"Video Choose");
                    [self chooseVideo];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}
/**
 *  Call function if user choose camera optino in actionsheet.
 */
-(void)chooseCamera {
    captureMode = @"Image";
     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
     picker.delegate = self;
     picker.sourceType = UIImagePickerControllerSourceTypeCamera;
     picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
     picker.showsCameraControls = YES;
     [self presentViewController:picker animated:YES completion:^ {}];
}
/**
 *  *  Call function if user choose video optino in actionsheet.
 */
-(void)chooseVideo{
    captureMode = @"Video";
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [self presentViewController:picker animated:YES completion:NULL];
}
#pragma  mark ImagePicker Delegates
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info{
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
//  NSString *getUserId = [askQuestionUserDefaults objectForKey:@"user_id"];
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
         self.addImageShow.image= imageNameCaptureByCamera;
        /**
         *  Folder Name in File manager
         *
         *  @param NSDocumentDirectory Document Path
         *
         */
        NSString *fileManagerPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"GoSign/Images"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:fileManagerPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:fileManagerPath withIntermediateDirectories:NO attributes:nil error:&error];
        NSMutableString *imageName = [NSMutableString stringWithFormat:@"%@%@%@",@"12",date,@".png"];
        NSLog(@"ImageName=======================%@",imageName);
        NSString *fileName = [fileManagerPath stringByAppendingFormat:@"/%@",imageName];
        NSLog(@"File Name Which is store to FileManager========================%@",fileName);
        NSData *data = UIImageJPEGRepresentation(imageNameCaptureByCamera, 1.0);
        [data writeToFile:fileName atomically:YES];
        
    } else if ([captureMode isEqualToString:@"Video"]) {
        NSURL *chosenMovie = [info objectForKey:UIImagePickerControllerMediaURL];
        NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSMutableString *imageName = [NSMutableString stringWithFormat:@"GoSign/Video/%@%@%@",@"12",date,@".mp4"];
        documentsURL = [documentsURL URLByAppendingPathComponent:imageName];
        NSURL *fileURL = documentsURL;
        videoUrl = documentsURL;
        NSData *movieData = [NSData dataWithContentsOfURL:chosenMovie];
        [movieData writeToURL:fileURL atomically:YES];
      //  UISaveVideoAtPathToSavedPhotosAlbum([chosenMovie path], nil, nil, nil);
       // NSURL *videoURL = [NSURL fileURLWithPath:[imagesArray objectAtIndex:indexPath.row]];
        MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
        UIImage *thumbnail = [player thumbnailImageAtTime:1 timeOption:MPMovieTimeOptionNearestKeyFrame];
        NSData *imgData = UIImagePNGRepresentation(thumbnail);
       addVideoThumbnailsShow.image = [UIImage imageWithData:imgData];
      //  cell.tag = indexPath.row;
        dispatch_async(dispatch_get_main_queue(), ^{
            UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVideo:)];
            tapped.numberOfTapsRequired = 1;
            [addVideoThumbnailsShow addGestureRecognizer:tapped];
        });
    }
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}
#pragma  mark Video player Delgates.
-(void)playVideo :(id) sender
{
    
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSURL *streamURL = videoUrl;
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
#pragma mark TextFields delegates.
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [currentTextField resignFirstResponder];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}
#pragma mark Button Clicked functions
- (IBAction)submitButtonClicked:(id)sender {

   
    NSData *imageData = UIImageJPEGRepresentation(addImageShow.image, 1.0f);
    if(imageData == nil){
        UIAlertView *imageAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Choose A Image" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [imageAlert show];
    }else if(videoUrl == nil){
        UIAlertView *videoAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Choose A Video" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [videoAlert show];
    }else if(textQuestionTextField.text.length < 5){
        UIAlertView *textAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Write Your Question" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [textAlert show];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            activityIndicator = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
            activityIndicator.label.text = @"Upload Files.";
        });
        NSURL *url = [NSURL URLWithString:@"http://150.129.180.38:8080/SignaturApp_webservices/rest/fileupload/file/"];
        NSString *userId = [signupFileChooseUserDefaults objectForKey:@"user_id"];
        NSString *userPlanId = [signupFileChooseUserDefaults objectForKey:@"user_plan_id"];
        NSString *text = textQuestionTextField.text;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *boundary = @"------------------------------gc0p4Jq0M2Yt08jU534c0p";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSMutableData *body = [NSMutableData data];
    
        /**
         *  Parameter First
         */
    
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"user_id"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n",userId]dataUsingEncoding:NSUTF8StringEncoding]];
    
        /**
         *  Parameters Second
         */
    
    
    
    
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"user_plan_id"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n",userPlanId]dataUsingEncoding:NSUTF8StringEncoding]];
        /**
         *  Parameter Third
         */
    
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"text"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n",text]dataUsingEncoding:NSUTF8StringEncoding]];
    
        /**
         *  Image File Parameters
         */
    
    
    
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@_%@.jpg\"\r\n", @"video",@"file",@"filenm"] dataUsingEncoding:NSUTF8StringEncoding]];
    
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
        /**
         *  Video File Parameters
         */
    
    
    
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@_%@.mp4\"\r\n", @"image",@"video",@"filenm"] dataUsingEncoding:NSUTF8StringEncoding]];
    
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *videoData = [NSData dataWithContentsOfFile:videoUrl];
        [body appendData:videoData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
        /**
         *   Boundry Lines
         */
    
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        NSLog(@"video url======%@",videoUrl);
        NSString *requestReplyy = [[NSString alloc] initWithData:body encoding:NSASCIIStringEncoding];
        NSLog(@"Parameter Which Send to server on dignup time file upload =========================================================%@",requestReplyy);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            /**
             Decode Data into JSON
    
             - returns: JSON Type Data
             */
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"Get Data from the server =========================================================%@",requestReply);
            /**
             *  Show response of request.
             */
    
            NSLog(@"Get Response from the server =========================================================%@",response);
            /**
             *  Show error of request
             */
            NSLog(@"Get Error from the server =========================================================%@",error);
            NSError *localError;
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
            
            /**
             *  Show full json data after parse using NSJSONSerialization.
             */
            for (NSDictionary *data in parsedJSON) {
                NSString *result = data[@"result"];
                if([result  isEqual: @"success"]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [activityIndicator hideAnimated:YES];
                        UIStoryboard *tagEditor = [self.storyboard instantiateViewControllerWithIdentifier:@"GSUserTabBarController"];
                        [self presentModalViewController:tagEditor animated:YES];
                    });
                    
                }else{
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [activityIndicator hideAnimated:YES];
                    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Again Upload" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [errorAlert show];
                     });
                }
            }
          
            
        }] resume];
    }
}
@end
