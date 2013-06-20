//
//  LocationBrain.h
//  HiddenNYC
//
//  Created by Axel Nunez on 1/5/13.
//  Copyright (c) 2013 CISDD.axel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationBrain : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

-(void)takeCurrentLocation;
@end
