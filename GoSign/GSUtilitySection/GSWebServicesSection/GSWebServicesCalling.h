//
//  GSWebServicesCalling.h
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 23/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  A class file name which is use for calling global webservice
 
 */
@interface GSWebServicesCalling : UIViewController

/**
 *  Return the data after get data from the server
 *
 */
typedef void (^GSAuthCompletion) (id jsonResponse, NSError * error);
/**
 *  A global function which is use for send request to server.
 *
 *  @param urlAddress  Address of the URL.
 *  @param password    Parameters which is required.
 *  @param completion  Call after get the data from the server
 */
+ (void) signInAccountWithUserName: (NSString *)urlAddress :(NSString *)parameters completion: (GSAuthCompletion)completion;
@end
