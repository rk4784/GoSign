//
//  GSUserContactUsViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 22/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSUserContactUsViewController.h"
#import "GSColorsDeclarationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GSUserContactUsViewController ()

@end

@implementation GSUserContactUsViewController
@synthesize userContactUsBackgroundImage,contactUsButtonOutlet,contactUsImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
   // self.view.backgroundColor = [UIColor colorWithRed:0.102 green:0.37 blue:0.612 alpha:1.000];
    self.contactUsButtonOutlet.layer.cornerRadius = 3;
    self.contactUsImage.layer.cornerRadius = contactUsImage.frame.size.height /2.8;
    [self.contactUsButtonOutlet.layer setShadowOffset:CGSizeMake(5, 5)];
    [self.contactUsButtonOutlet.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.contactUsButtonOutlet.layer setShadowOpacity:0.5];
    
    
    
    NSString *dateString2Prev;
    NSString *weekstartPrev;
    NSString *dateEndPrev;
    NSString *weekEndPrev;
    NSDate *today = [NSDate date];
    NSLog(@"Today date is %@",today);
     NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init] ;
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
    
    //Week Start Date
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    int dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today] weekday];// this will give you current day of week
    
    [components setDay:([components day] - ((dayofweek) - 2))];// for beginning of the week.
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateFormat_first = [[NSDateFormatter alloc] init];
    [dateFormat_first setDateFormat:@"yyyy-MM-dd"];
    dateString2Prev = [dateFormat stringFromDate:beginningOfWeek];
    
    weekstartPrev = [dateFormat_first dateFromString:dateString2Prev] ;
    
    NSLog(@"%@",weekstartPrev);
    
    
    //Week End Date
    
    NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *componentsEnd = [gregorianEnd components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    int Enddayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today] weekday];// this will give you current day of week
    
    [componentsEnd setDay:([componentsEnd day]+(7-Enddayofweek)+1)];// for end day of the week
    
    NSDate *EndOfWeek = [gregorianEnd dateFromComponents:componentsEnd];
    NSDateFormatter *dateFormat_End = [[NSDateFormatter alloc] init];
    [dateFormat_End setDateFormat:@"yyyy-MM-dd"];
    dateEndPrev = [dateFormat stringFromDate:EndOfWeek];
    
    weekEndPrev = [dateFormat_End dateFromString:dateEndPrev] ;
    NSLog(@"%@",weekEndPrev);
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
