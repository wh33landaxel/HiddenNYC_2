//
//  HNYCFavoritesVC.h
//  HiddenNYC
//
//  Created by Axel Nunez on 1/18/13.
//  Copyright (c) 2013 CISDD.axel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNYCFavoritesVC : UITableViewController
@property (nonatomic, strong) NSDictionary * defaultDict;
@property (nonatomic, strong) NSDictionary * favDict;

-(void)setDefaultDict:(NSDictionary *)defaultDict;
@end
