//
// Created by Giordano Scalzo on 01/11/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "MapViewModel.h"
#import "Emitter.h"
#import "LocationDatastore.h"
#import "Common.h"


@interface MapViewModel ()
@property(nonatomic, strong) LocationDatastore *locationManager;
@property(nonatomic) BOOL inSelectingPinmarkState;
@end

@implementation MapViewModel

- (id)init
{
    if(self = [super init]) {
        self.emitter = [Emitter new];
    }
    return self;
}


- (id)initWithLocationManager:(LocationDatastore *)manager {
    if(self = [self init]) {
        self.locationManager = manager;
        self.spanLat = 0.01;
        self.spanLong = 0.01;
        self.pinButtonImage = @"map.icon.pinimage";
        self.viewfinderHidden = YES;

        WSELFY
        [self.locationManager.emitter subscribe:self on:^{
            weakSelf.coordinate = self.locationManager.coordinate;
            [weakSelf.emitter emit];
        }];
        [self.locationManager start];
    }
    return self;
}

- (void)dealloc{
    [self.emitter unsubscribe:self];
}

- (void)pressActionButtonWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if (self.inSelectingPinmarkState) {
        self.pinButtonImage = @"map.icon.pinimage";
        self.viewfinderHidden = YES;
        self.inSelectingPinmarkState = NO;
        self.pinmarkCoordinate = coordinate;
        self.askForAName = YES;
        self.coordinate = CLLocationCoordinate2DMake(0, 0);
    } else {
        self.pinButtonImage = @"map.icon.viewfinderimage";
        self.viewfinderHidden = NO;
        self.inSelectingPinmarkState = YES;
        self.askForAName = NO;
    }

    [self.emitter emit];
}


- (void)addPinmarkName:(NSString *)string coordinate:(CLLocationCoordinate2D)coordinate {
    self.freshlyAddedPins = @[@1];
    self.askForAName = NO;
    [self.emitter emit];
}

@end