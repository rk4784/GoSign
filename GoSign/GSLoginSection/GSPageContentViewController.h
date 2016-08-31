//
//  GSPageContentViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 20/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSPageContentViewController : UIViewController
    @property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    @property NSUInteger pageIndex;
    @property NSString *titleText;
    @property NSString *imageFile;
@end
