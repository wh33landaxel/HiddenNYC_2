/*
 File: ViewController.m
 Abstract: The primary view controller for this app.
 
 Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 
 */

#import "HNYCPhotoViewController.h"
#import "Cell.h"
#import "DetailViewController.h"


NSString *kDetailedViewControllerID = @"DetailView";    // view controller storyboard id
NSString *kCellID = @"cellID";                          // UICollectionViewCell storyboard id
@interface HNYCPhotoViewController ()

@end

@implementation HNYCPhotoViewController
@synthesize numPics = _numPics;
@synthesize photoDict = _photoDict;
@synthesize placeName = _placeName;
@synthesize mainDict = _mainDict;
@synthesize address = _address;

- (void) setNumPics:(NSNumber *)numPics{
    if(!_numPics){
        _numPics = [[NSNumber alloc] init];
        _numPics = numPics;
    }
    else
        _numPics = numPics;
}

- (void) setPhotoDict:(NSDictionary *)photoDict{
    if(!_photoDict){
        _photoDict = [[NSDictionary alloc]initWithDictionary:photoDict];
    }
    else
        _photoDict = photoDict;
    
}

- (void) setPlaceName:(NSString *)placeName {
    if(_placeName){
        _placeName = [[NSString alloc]initWithString:placeName];
    }
    else
        _placeName = placeName;
}

-(void) setMainDict:(NSDictionary *)mainDict{
    if(!_mainDict)
        _mainDict = [[NSDictionary alloc]initWithDictionary:mainDict];
    else
        _mainDict = mainDict;
    
}

-(void) setAddress:(NSString *)address{
    if(!_address)
        _address = [[NSString alloc] initWithString:address];
    else
        _address = address;
    
    
}




- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
   // NSLog(@"%@", _address);
//    NSLog(@"%@",_placeName);
    NSLog(@"%@", _mainDict);
    [self setPhotoDict:[_mainDict objectForKey:_address]];
  //  NSLog(@"%@", _photoDict);
    NSInteger numImages = [[_photoDict objectForKey:@"numImages"] integerValue];
  //  NSLog(@"%i", numImages);
    return numImages;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    // make the cell's title the actual NSIndexPath value
    //cell.label.text = [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];
    
    // load the image for this cell
    NSString *imageToLoad = [NSString stringWithFormat:@"%d%@.jpg", indexPath.row ,[_photoDict objectForKey:@"imageTag"]];
    cell.image.image = [UIImage imageNamed:imageToLoad];
    
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
         NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        
        // load the image, to prevent it from being cached we use 'initWithContentsOfFile'
        NSString *imageNameToLoad = [NSString stringWithFormat:@"%d%@", selectedIndexPath.row ,[_photoDict objectForKey:@"imageTag"]];
      //  NSString *imageNameToLoad = @"FreedomTunnel1";
        NSString *pathToImage = [[NSBundle mainBundle] pathForResource:imageNameToLoad ofType:@"jpg"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathToImage];
        
        DetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.image = image;
    }
}

@end
