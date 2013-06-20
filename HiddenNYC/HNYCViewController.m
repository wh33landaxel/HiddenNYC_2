//
//  HNYCViewController.m
//  HiddenNYC
//
//  Created by Axel Nunez on 12/30/12.
//  Copyright (c) 2012 CISDD.axel. All rights reserved.
//

#import "HNYCViewController.h"
#import "HNYCDescriptionVC.h"
#import "LocationBrain.h"
#import "HNYCSearchVC.h"
#import "HNYCFavoritesVC.h"


@interface HNYCViewController ()
@property (strong, nonatomic) NSDictionary *dictionary;
@property (strong,nonatomic) LocationBrain *LB;
@property (weak, nonatomic) NSString * placeName;
@property (weak, nonatomic) NSString * placeDescription;
@end

@implementation HNYCViewController

@synthesize dictionary = _dictionary;
@synthesize LB = _LB;
@synthesize placeDescription;
@synthesize placeName;

- (IBAction)updateCurrentLocation:(id)sender {
    if(!_LB){
        _LB = [[LocationBrain alloc] init];
    }
    
    [_LB takeCurrentLocation];
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setDictionary:[self loadJSONData]];
    
    _LB = [[LocationBrain alloc] init];
    
    [_LB takeCurrentLocation];
    
    // Here it would find the address closest
    
    // ... code
    
    // Since that code doesn't run I'm going to use a default location
    
    [self setPlaceName:[[_dictionary objectForKey: @"125th St and Riverside Park, Manhattan, NY" ] objectForKey:@"name"]];
    [self setPlaceDescription:[[_dictionary objectForKey: @"125th St and Riverside Park, Manhattan, NY" ] objectForKey:@"description"]];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)setDictionary:(NSDictionary *)dictionary{
    if(!_dictionary){
        _dictionary = [[NSDictionary alloc] initWithDictionary:dictionary];
    }
    else
        _dictionary = dictionary;
    
}

-(NSDictionary *)loadJSONData{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Description" ofType:@"json"];
    NSData * JSONData = [[NSData alloc]initWithContentsOfFile:path] ;
    NSError * error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:&error];
    return dictionary;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"New Description"]) {
        [segue.destinationViewController setTitle: placeName];
        [segue.destinationViewController setDescription:placeDescription];
        [segue.destinationViewController setPlaces : _dictionary];
        
    }
    else if([segue.identifier isEqualToString:@"beginSearch"]){
        [segue.destinationViewController setPlaceDict:_dictionary];
        
    }
    else if([segue.identifier isEqualToString:@"favorites"]){
        NSLog(@"%@",_dictionary);
        [segue.destinationViewController setDefaultDict:_dictionary];
        
    }
}




@end
