//
//  GSUserAnalysisTableViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 23/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserAnalysisTableViewController.h"
#import "GSWebServicesCalling.h"
#import "GSUserMyAnalysisDetailsShowViewController.h"
#import "MBProgressHUD.h"
@interface GSUserAnalysisTableViewController ()

@end

@implementation GSUserAnalysisTableViewController {
    /**
     *  NSMutableArray for store question.
     */
    NSMutableArray *userAnalysisQuestionList;
    /**
     * NSMutableArray for store questionId.
     */
    NSMutableArray *userAnalysisQuestionId;
    NSUserDefaults *userMyAnalysisDefaults;
    /**
     *  Int use for get questionId which is select by user.
     */
    NSInteger *selectedQuestionIndexPath;
    
}
@synthesize signatureMode;
- (void)viewDidLoad {
    [super viewDidLoad];
    userAnalysisQuestionList = [[NSMutableArray alloc]init];
    userAnalysisQuestionId = [[NSMutableArray alloc]init];
    userMyAnalysisDefaults = [NSUserDefaults standardUserDefaults];
     self.clearsSelectionOnViewWillAppear = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem *changeTitleOfBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:changeTitleOfBackButton];
    NSString *urlAddress = @"http://150.129.180.38:8080/SignaturApp_webservices/rest/list/for_user/";
    NSString *parameters = [NSString stringWithFormat:@"user_id=%@",[userMyAnalysisDefaults objectForKey:@"user_id"]];
    [GSWebServicesCalling signInAccountWithUserName:urlAddress :parameters completion:^(id jsonResponse, NSError *error) {
        //  NSString *requestReply = [[NSString alloc] initWithData:jsonResponse encoding:NSASCIIStringEncoding];
        NSError *localError = nil;
        if (jsonResponse != nil) {
            [userAnalysisQuestionList removeAllObjects];
            [userAnalysisQuestionId removeAllObjects];
            self.navigationItem.rightBarButtonItem = self.editButtonItem;
            NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:jsonResponse options:0 error:&localError];
            /**
             *  Show full json data after parse using NSJSONSerialization.
             */
            
            for (NSDictionary *data in parsedJSON) {
                NSString *questionId = [data objectForKey:@"question_id"];
                NSString *question = [data objectForKey:@"question"];
                NSString *capitalizedString = [question capitalizedString];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [userAnalysisQuestionList addObject:capitalizedString];
                    [userAnalysisQuestionId addObject:questionId];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            if([signatureMode  isEqual: @"NoAlert"]) {
            } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Question Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [userAnalysisQuestionList count];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userAnalysisTableCell" forIndexPath:indexPath];
    cell.textLabel.text = [userAnalysisQuestionList objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:17];
    return cell;
}
 //Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    [userAnalysisQuestionList removeObjectAtIndex:indexPath.row];
    [userAnalysisQuestionId removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected Question ID============================%@",[userAnalysisQuestionId objectAtIndex:indexPath.row]);
    selectedQuestionIndexPath = indexPath.row;
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GSUserMyAnalysisDetailsShowViewController *vc = segue.destinationViewController;
    vc.questionId = [userAnalysisQuestionId objectAtIndex:selectedQuestionIndexPath];
}


@end
