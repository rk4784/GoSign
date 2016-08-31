//
//  GSColorsDeclarationViewController.m
//  GoSign
//
//  Created by Rahul Yadav (Contractor) on 22/04/16.
//  Copyright © 2016 Rahul Yadav (Contractor). All rights reserved.
//

#import "GSColorsDeclarationViewController.h"

@interface UIColor()

@end

@implementation UIColor(NewColor)
/**
 *  Left Border color in userHomePage.
 *
 *  @return DodoblueColor
 */
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]
+(UIColor *) leftBorderColor {
   return  UIColorFromRGB(0x22415D);
    //return [UIColor colorWithRed:10.0/255.0 green:91.0/255.0 blue:196.0/255.0 alpha:1.0];
}
+(UIColor *) ReDesignGradientColorUpper {
    return UIColorFromRGB(0x16222A);
}
+(UIColor *) ReDesignGradientColorLower {
    return UIColorFromRGB(0x3A6073);
}
+(UIColor *) topColor {
    return UIColorFromRGB(0x6197BA);
}
+(UIColor *) bottomColor {
    return UIColorFromRGB(0x095D93);
}
@end
