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
        __block MapViewModel *vm;

        beforeEach(^{
            vm = [[MapViewModel alloc] initWithLocationManager:[TestLocationManager new]];
        });


        afterEach(^{
            [vm.emitter unsubscribe:self];
        });

        it(@"should have an Emitter", ^{
            MapViewModel *vm = [MapViewModel new];
            [[vm.emitter should] beNonNil];
        });

        it(@"should have invalid coordinates when it starts ", ^{
            [[theValue(vm.coordinate.latitude) should] equal:theValue(0)];
            [[theValue(vm.coordinate.longitude) should] equal:theValue(0)];
        });

        it(@"should have coordinates of the user", ^{
            __block CLLocationCoordinate2D futureCoordinate = vm.coordinate;
            [vm.emitter subscribe:self on:^{
                futureCoordinate = vm.coordinate;
            }];

            [[expectFutureValue(theValue(futureCoordinate.latitude)) shouldEventually] equal:theValue(20)];
            [[expectFutureValue(theValue(futureCoordinate.longitude)) shouldEventually] equal:theValue(10)];
        });

        it(@"should have coordinate span around the user", ^{
            [[theValue(vm.spanLat) should] equal:theValue(0.01)];
            [[theValue(vm.spanLong) should] equal:theValue(0.01)];
        });

        context(@"actions", ^{

            context(@"starting", ^{
                it(@"should start with pinimage for the button", ^{
                    [[vm.pinButtonImage should] equal:@"map.icon.pinimage"];
                });

                it(@"should start with viewfinder hidden", ^{
                    [[theValue(vm.viewfinderHidden) should] beTrue];
                });
            });

            context(@"when the pin button is pressed", ^{
                it(@"should have a viewfinder button", ^{
                    __block NSString *futureButtonImage = vm.pinButtonImage;
                    [vm.emitter subscribe:self on:^{
                        futureButtonImage = vm.pinButtonImage;
                    }];

                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(0, 0)];
                    [[expectFutureValue(futureButtonImage) shouldEventually] equal:@"map.icon.viewfinderimage"];
                });

                it(@"should show the viewfinder", ^{
                    __block BOOL futureviewfinderHidden = vm.viewfinderHidden;
                    [vm.emitter subscribe:self on:^{
                        futureviewfinderHidden = vm.viewfinderHidden;
                    }];

                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(0, 0)];
                    [[expectFutureValue(theValue(futureviewfinderHidden)) shouldEventually] beFalse];
                });
            });

            context(@"when the viewfinder button is pressed", ^{
                it(@"should hide the viewfinder ", ^{
                    __block BOOL futureviewfinderHidden = vm.viewfinderHidden;
                    [vm.emitter subscribe:self on:^{
                        futureviewfinderHidden = vm.viewfinderHidden;
                    }];

                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(0, 0)];
                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(10, 20)];
                    [[expectFutureValue(theValue(futureviewfinderHidden)) shouldEventually] beTrue];
                });

                it(@"should have a pin coordinte", ^{
                    __block CLLocationCoordinate2D futureviewPinmarkCoordinate = vm.pinmarkCoordinate;
                    [vm.emitter subscribe:self on:^{
                        futureviewPinmarkCoordinate = vm.pinmarkCoordinate;
                    }];

                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(0, 0)];
                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(10, 20)];
                    [[expectFutureValue(theValue(futureviewPinmarkCoordinate.latitude)) shouldEventually] equal:theValue(10)];
                    [[expectFutureValue(theValue(futureviewPinmarkCoordinate.longitude)) shouldEventually] equal:theValue(20)];
                });

                it(@"should ask for a name", ^{
                    __block BOOL futureAskForAName = vm.askForAName;
                    [vm.emitter subscribe:self on:^{
                        futureAskForAName = vm.askForAName;
                    }];
                    [[theValue(futureAskForAName) should] beFalse];

                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(0, 0)];
                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(10, 20)];
                    [[expectFutureValue(theValue(futureAskForAName)) shouldEventually] beTrue];
                });
            });

            context(@"when set the name", ^{
                it(@"should have a new pinmark ", ^{

                });
                it(@"should not ask for a name ", ^{
                    __block BOOL futureAskForAName = vm.askForAName;
                    [vm.emitter subscribe:self on:^{
                        futureAskForAName = vm.askForAName;
                    }];
                    [[theValue(futureAskForAName) should] beFalse];

                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(0, 0)];
                    [vm pressActionButtonWithCoordinate:CLLocationCoordinate2DMake(10, 20)];
                    [[expectFutureValue(theValue(futureAskForAName)) shouldEventually] beTrue];
                });
            });
        });
    });
SPEC_END