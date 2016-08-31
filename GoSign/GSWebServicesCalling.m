//
//  GSWebServicesCalling.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 23/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSWebServicesCalling.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GSWebServicesCalling ()

@end

@implementation GSWebServicesCalling
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)signInAccountWithUserName:(NSString *)urlAddress :(NSString *)parameters completion: (GSAuthCompletion)completion; {
    NSLog(@"Sending Request To Server===============================");
    NSLog(@"%@",urlAddress);
    NSLog(@"%@",parameters);
    /**
     *  return value after success request
     */
    __block GSAuthCompletion blk = completion;
    NSString *post = [NSString stringWithFormat:@"%@",parameters];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlAddress]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        /**
         Decode Data into JSON
         
         - returns: JSON Type Data
         */
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"Send request To Server Data =========================================================%@",requestReply);
        /**
         *  Show response of request.
         */
       
        NSLog(@"Send request To Server Response =========================================================%@",response);
        /**
         *  Show error of request
         */
        NSLog(@"Send request To Server Error =========================================================%@",error);
        if([requestReply length] > 2) {
            NSLog(@"JSON NOT NIL============================================================");
           blk(data,nil);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                 NSLog(@"JSON NIL============================================================");
              //  NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"error",@"error", nil];
                blk(nil,nil);
            });
        };
    }] resume];
}
@end
