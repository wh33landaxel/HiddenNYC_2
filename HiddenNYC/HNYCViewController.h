//
//  HNYCViewController.h
//  HiddenNYC
//
//  Created by Axel Nunez on 12/30/12.
//  Copyright (c) 2012 CISDD.axel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNYCViewController : UIViewController
-(NSDictionary *) loadJSONdata;
-(void)setDictionary: (NSDictionary *) dictionary;

@end
