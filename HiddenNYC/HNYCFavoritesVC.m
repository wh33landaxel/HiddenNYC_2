//
//  HNYCFavoritesVC.m
//  HiddenNYC
//
//  Created by Axel Nunez on 1/18/13.
//  Copyright (c) 2013 CISDD.axel. All rights reserved.
//

#import "HNYCFavoritesVC.h"
#import "HNYCDescriptionVC.h"

@interface HNYCFavoritesVC ()

@end

@implementation HNYCFavoritesVC
@synthesize defaultDict = _defaultDict;
@synthesize favDict = _favDict;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setDefaultDict:(NSDictionary *)defaultDict{
    if(!_defaultDict)
        _defaultDict = [[NSDictionary alloc]initWithDictionary:defaultDict];
    else
        _defaultDict = defaultDict;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   NSUserDefaults * prefs = [[NSUserDefaults alloc]init];
   NSMutableArray * favs =  [prefs objectForKey:@"favoritesArray"];    
    
    // Return the number of rows in the section.
    return favs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSUserDefaults *prefs = [[NSUserDefaults alloc]init];
    NSMutableArray *favArray = [prefs objectForKey:@"favoritesArray"];
    cell.textLabel.text = [[favArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = @"";
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
    
    if([segue.identifier isEqualToString:@"Favorite Description"]){
        UITableViewCell * cell;
        if ([sender isKindOfClass:[UITableViewCell class]]){
            cell = sender;
        }
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        //Create a dictionary for the specified location from the placeArray
        NSDictionary * dict;
        NSUserDefaults *prefs = [[NSUserDefaults alloc]init];
        NSMutableArray *favArray = [prefs objectForKey:@"favoritesArray"];
        dict = [[NSDictionary alloc] initWithDictionary: [favArray objectAtIndex:indexPath.row]];
 
        //Pick the values for the name and description out of the dictionary
        NSString * name = [dict objectForKey:@"name"];
        NSString * description = [dict objectForKey: @"description"];
        NSString *address = [dict objectForKey:@"address"];
        [segue.destinationViewController setTitle:name];
        [segue.destinationViewController setDescription:description];
        [segue.destinationViewController setAddress :address];
        [segue.destinationViewController setPlaces:self.defaultDict];
        
        
    }
    
}

@end
