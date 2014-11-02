//
//  LocationDatastore.m
//  PinmarkApp
//
//  Created by Giordano Scalzo on 01/11/2014.
//  Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "LocationDatastore.h"
#import "Emitter.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationDatastore () <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *iosLocationManager;

@end

@implementation LocationDatastore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iosLocationManager = [CLLocationManager new];
        [self.iosLocationManager requestWhenInUseAuthorization];
        self.iosLocationManager.delegate = self;
        self.emitter = [Emitter new];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    self.coordinate = location.coordinate;
    self.eventDate = eventDate;
    [self.emitter emit];
    [self.iosLocationManager stopUpdatingLocation];

//    // If it's a relatively recent event, turn off updates to save power.
//    CLLocation* location = [locations lastObject];
//    NSDate* eventDate = location.timestamp;
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    if (abs((int) howRecent) < 15.0) {
//        // If the event is recent, do something with it.
//        NSLog(@"latitude %+.6f, longitude %+.6f\n",
//                location.coordinate.latitude,
//                location.coordinate.longitude);
//        self.coordinate = location.coordinate;
//        [self.emitter emit];
//    }
}

- (void)start {
    [self.iosLocationManager startUpdatingLocation];
}


@end
