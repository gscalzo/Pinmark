//
// Created by Giordano Scalzo on 01/11/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class LocationDatastore;


@interface MapViewModel : NSObject
@property(nonatomic, strong) id emitter;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, assign) double spanLat;
@property(nonatomic, assign) double spanLong;

- (id)initWithLocationManager:(LocationDatastore *)manager;

@end