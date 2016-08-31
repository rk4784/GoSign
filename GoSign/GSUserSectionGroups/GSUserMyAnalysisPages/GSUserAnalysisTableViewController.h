//
//  GSUserAnalysisTableViewController.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 23/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GSUserAnalysisTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
@property ( nonatomic, strong ) NSString *signatureMode;
@end
