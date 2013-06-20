//
//  HNYCSearchVC.m
//  HiddenNYC
//
//  Created by Axel Nunez on 1/13/13.
//  Copyright (c) 2013 CISDD.axel. All rights reserved.
//

#import "HNYCSearchVC.h"
#import "HNYCDescriptionVC.h"

@interface HNYCSearchVC ()

@end

@implementation HNYCSearchVC
@synthesize placeDict = _placeDict;
@synthesize placeArray = _placeArray;


-(void)setPlaceDict:(NSDictionary *)placeDict{
    if(!_placeDict){
        _placeDict = [[NSDictionary alloc] initWithDictionary:placeDict];
    } else
        _placeDict = placeDict;
}

-(void)setPlaceArray:(NSArray *)placeArray{
    if(!_placeArray)
        _placeArray = [[NSArray  alloc]initWithArray:placeArray];
    else
        _placeArray = placeArray;
    
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/* ---TO BE IMPLEMENTED LATER BY FILTER---
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 #warning Potentially incomplete method implementation.
 // Return the number of sections.
 return 0;
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.placeDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Search Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Values in array of places, name is the place name
    NSDictionary *dict;
    
    // Places the dictionary into a Array for easier implementation
    NSArray *placeDetail = [[NSArray alloc] initWithArray:[_placeDict allValues]];
    
    // Alphabetizes the array by place name
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    placeDetail = [placeDetail sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    [self setPlaceArray:placeDetail];
    
    //Prints the title table row
    dict = [placeDetail objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"name"];
    cell.detailTextLabel.text = @"";
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Search Description"]){
        UITableViewCell * cell;
        if ([sender isKindOfClass:[UITableViewCell class]]){
            cell = sender;
        }
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        //Create a dictionary for the specified location from the placeArray
        NSDictionary * dict;
        dict = [[NSDictionary alloc] initWithDictionary: [_placeArray objectAtIndex:indexPath.row]];
        
        //Pick the values for the name and description out of the dictionary
        NSString * name = [dict objectForKey:@"name"];
        NSString * description = [dict objectForKey: @"description"];
        NSString *address = [dict objectForKey:@"address"];
        [segue.destinationViewController setTitle:name];
        [segue.destinationViewController setDescription:description];
        [segue.destinationViewController setAddress :address];
        [segue.destinationViewController setPlaces:_placeDict];
        
        
    }
    
}

@end
