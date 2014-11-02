//
// Created by Giordano Scalzo on 01/11/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "MapViewModel.h"
#import "Emitter.h"
#import "LocationManager.h"
#import "Common.h"


@interface MapViewModel ()
@property(nonatomic, strong) LocationManager *locationManager;
@end

@implementation MapViewModel

- (id)init
{
    if(self = [super init]) {
        self.emitter = [Emitter new];
    }
    return self;
}


- (id)initWithLocationManager:(LocationManager *)manager {
    if(self = [self init]) {
        self.locationManager = manager;

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

@end