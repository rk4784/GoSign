//
//  GSSignUpTimeFileChooserViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 12/05/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSSignUpTimeFileChooserViewController : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
- (IBAction)addButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addVideoThumbnailsShow;
@property (weak, nonatomic) IBOutlet UIImageView *addImageShow;
@property (weak, nonatomic) IBOutlet UIButton *submitButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *submitButtonClicked;
@property (weak, nonatomic) IBOutlet UITextField *textQuestionTextField;

- (IBAction)submitButtonClicked:(id)sender;

@end
