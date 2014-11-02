//
// Created by Giordano Scalzo on 01/11/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "MapViewModel.h"
#import "Emitter.h"
#import "LocationDatastore.h"

@interface TestLocationManager : LocationDatastore
@end

@implementation TestLocationManager

- (void)start {
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        self.coordinate = CLLocationCoordinate2DMake(20, 10);
        [self.emitter emit];
    });
}

@end


SPEC_BEGIN(MapViewModelSpec)
    describe(@"A MapViewModel", ^{
        it(@"should have an Emitter", ^{
            MapViewModel *vm = [MapViewModel new];
            [[vm.emitter should] beNonNil];
        });

        it(@"should have coordinate of the user", ^{
            LocationDatastore *locationManager = [TestLocationManager new];

            MapViewModel *vm = [[MapViewModel alloc] initWithLocationManager:locationManager];

            [[theValue(vm.coordinate.latitude) should] equal:theValue(0)];
            [[theValue(vm.coordinate.longitude) should] equal:theValue(0)];
            __block CLLocationCoordinate2D futureCoordinate = vm.coordinate;
            [vm.emitter subscribe:self on:^{
                futureCoordinate = vm.coordinate;
            }];

            [[expectFutureValue(theValue(futureCoordinate.latitude)) shouldEventually] equal:theValue(20)];
            [[expectFutureValue(theValue(futureCoordinate.longitude)) shouldEventually] equal:theValue(10)];
        });

        it(@"should have coordinate span around the user", ^{
            MapViewModel *vm = [[MapViewModel alloc] initWithLocationManager:nil];
            [[theValue(vm.spanLat) should] equal:theValue(0.01)];
            [[theValue(vm.spanLong) should] equal:theValue(0.01)];
        });

    });
SPEC_END