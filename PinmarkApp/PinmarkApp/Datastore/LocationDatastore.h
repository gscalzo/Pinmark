//
//  LocationDatastore.h
//  PinmarkApp
//
//  Created by Giordano Scalzo on 01/11/2014.
//  Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationDatastore : NSObject

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) id emitter;
@property(nonatomic, strong) NSDate *eventDate;

- (void)start;
@end
