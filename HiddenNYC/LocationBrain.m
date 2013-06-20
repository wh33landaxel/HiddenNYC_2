//
//  LocationBrain.m
//  HiddenNYC
//
//  Created by Axel Nunez on 1/5/13.
//  Copyright (c) 2013 CISDD.axel. All rights reserved.
//

#import "LocationBrain.h"

@interface LocationBrain()
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) NSDictionary *dictionary;


@property (strong, nonatomic) CLGeocoder *geocoder;


@end
@implementation LocationBrain


-(void)takeCurrentLocation{
    if (self.manager == nil)
        self.manager = [[CLLocationManager alloc] init];
    
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.manager startUpdatingLocation];
}

-(NSDictionary *)loadJSONData{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Description" ofType:@"json"];
    NSData * JSONData = [[NSData alloc]initWithContentsOfFile:path] ;
    NSError * error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:&error];
    return dictionary;
}

- (void) forwardGeocode:(CLLocation *)location :(NSString *) weirdAddress
{
    
    
    if (self.geocoder == nil)
        self.geocoder = [[CLGeocoder alloc] init];
          NSString *address = weirdAddress;
            [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
         //       NSLog(@"%@",address);

                if ([placemarks count] > 0) {
                    CLPlacemark *placemark = [placemarks objectAtIndex:0];
                    CLLocation *loc = placemark.location;
           //         CLLocationCoordinate2D coordinate = loc.coordinate;
           //         CLLocationDistance  dis = [location distanceFromLocation: loc];
           //         NSLog(@"%f", dis/1609);
          //          NSLog(@"%@",[NSString stringWithFormat:@"%f, %f", coordinate.latitude, coordinate.longitude]);
                    if ([placemark.areasOfInterest count] > 0) {
                        //        self.nameLabel.text = [placemark.areasOfInterest objectAtIndex:0];
                        
                    } else {
                        NSLog(@"No Area of Interest Was Found");
                    }
                }
            }];
    
}


#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)aManager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if ([newLocation.timestamp timeIntervalSince1970] < [NSDate timeIntervalSinceReferenceDate] - 60)
        return;
    aManager.delegate = nil;
    [aManager stopUpdatingLocation];
    NSDictionary * dict = [self loadJSONData];

     //   [self reverseGeocode:newLocation:key];
    
    
    [dict enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent
usingBlock:^(id key, id object, BOOL *stop) {
    //NSLog(@"%@",key);
//    dispatch_async(getQueue, ^{
        [self forwardGeocode:newLocation:key];
}];
   // dispatch_release(getQueue);

}





- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error Getting Location: %@", [error localizedDescription]);
}


- (void)mapViewDidFailLoadingMap:(MKMapView *)aMapView withError:(NSError *)error
{
    NSLog(@"Error Loading Map: %@", [error localizedDescription]);
}




@end

