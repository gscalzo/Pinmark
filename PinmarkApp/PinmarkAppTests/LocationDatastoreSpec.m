//
// Created by Giordano Scalzo on 01/11/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "LocationDatastore.h"
#import "Emitter.h"
#import "LocationManager.h"


SPEC_BEGIN(LocationManagerSpec)
    describe(@"A LocationManager", ^{
        it(@"should have an Emitter", ^{
            LocationManager *lm = [LocationManager new];
            [[lm.emitter should] beNonNil];
        });
    });
SPEC_END

SPEC_BEGIN(LocationDatastoreSpec)
    describe(@"A LocationDatastore", ^{
        it(@"should have an Emitter", ^{
            LocationDatastore *vm = [LocationDatastore new];
            [[vm.emitter should] beNonNil];
        });

        it(@"should start with coordinate at nil", ^{

        });

        it(@"should emit only if the event is recent", ^{

        });
//        it(@"should start having childVC at index 0 to show", ^{
//            ContainerViewModel *vm = [ContainerViewModel new];
//            [theValue(vm.childVCIndexToShow) isEqual:theValue(0)];
//        });
//
//
//        it(@"should have an action to change the index to 1", ^{
//            ContainerViewModel *vm = [ContainerViewModel new];
//
//            __block NSInteger futureChildIndex = -1;
//            [vm.emitter subscribe:self on:^{
//                futureChildIndex = vm.childVCIndexToShow;
//            }];
//
//            [vm swapButtonPressed];
//            [[expectFutureValue(theValue(futureChildIndex)) shouldEventually] equal:theValue(1)];
//        });
//
//        it(@"should alternate the value of the child to show", ^{
//            ContainerViewModel *vm = [ContainerViewModel new];
//
//            __block NSInteger futureChildIndex = vm.childVCIndexToShow;
//            [vm.emitter subscribe:self on:^{
//                futureChildIndex = vm.childVCIndexToShow;
//            }];
//
//            [[expectFutureValue(theValue(futureChildIndex)) shouldEventually] equal:theValue(0)];
//            [vm swapButtonPressed];
//            [[expectFutureValue(theValue(futureChildIndex)) shouldEventually] equal:theValue(1)];
//            [vm swapButtonPressed];
//            [[expectFutureValue(theValue(futureChildIndex)) shouldEventually] equal:theValue(0)];
//        });
//
//        it(@"should alternate the image to show on the button", ^{
//            ContainerViewModel *vm = [ContainerViewModel new];
//
//            __block NSString *futureButtonImage = vm.buttonImage;
//            [vm.emitter subscribe:self on:^{
//                futureButtonImage = vm.buttonImage;
//            }];
//
//
//            [[expectFutureValue(futureButtonImage) shouldEventually] equal:@"icon.pinlist"];
//            [vm swapButtonPressed];
//            [[expectFutureValue(futureButtonImage) shouldEventually] equal:@"icon.map"];
//            [vm swapButtonPressed];
//            [[expectFutureValue(futureButtonImage) shouldEventually] equal:@"icon.pinlist"];
//        });

    });
SPEC_END