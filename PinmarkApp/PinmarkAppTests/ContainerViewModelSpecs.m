//
//  ContainerViewModelSpecs.m
//  PinmarkApp
//
//  Created by Giordano Scalzo on 31/10/14.
//  Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "ContainerViewModel.h"
#import "Emitter.h"

SPEC_BEGIN(ContainerViewModelSpec)
    describe(@"A ContainerViewMolde", ^{
        it(@"should have an Emitter", ^{
            ContainerViewModel *vm = [ContainerViewModel new];
            [[vm.emitter should] beNonNil];
        });

        it(@"should start having childVC at index 0 to show", ^{
            ContainerViewModel *vm = [ContainerViewModel new];
            [theValue(vm.childVCIndexToShow) isEqual:theValue(0)];
        });


        it(@"should have an action to change the index to 1", ^{
            ContainerViewModel *vm = [ContainerViewModel new];

            __block NSInteger futureChildIndex = -1;
            [vm.emitter subscribe:self on:^{
                futureChildIndex = vm.childVCIndexToShow;
            }];

            [vm swapButtonPressed];
            [[expectFutureValue(theValue(futureChildIndex)) shouldEventually] equal:theValue(1)];
        });

        it(@"should alternate the value of the child to show", ^{
            ContainerViewModel *vm = [ContainerViewModel new];

            __block NSInteger futureChildIndex = vm.childVCIndexToShow;
            [vm.emitter subscribe:self on:^{
                futureChildIndex = vm.childVCIndexToShow;
            }];

            [[expectFutureValue(theValue(futureChildIndex)) shouldEventually] equal:theValue(0)];
            [vm swapButtonPressed];
            [[expectFutureValue(theValue(futureChildIndex)) shouldEventually] equal:theValue(1)];
            [vm swapButtonPressed];
            [[expectFutureValue(theValue(futureChildIndex)) shouldEventually] equal:theValue(0)];
        });

        it(@"should alternate the image to show on the button", ^{
            ContainerViewModel *vm = [ContainerViewModel new];

            __block NSString *futureButtonImage = vm.buttonImage;
            [vm.emitter subscribe:self on:^{
                futureButtonImage = vm.buttonImage;
            }];


            [[expectFutureValue(futureButtonImage) shouldEventually] equal:@"icon.pinlist"];
            [vm swapButtonPressed];
            [[expectFutureValue(futureButtonImage) shouldEventually] equal:@"icon.map"];
            [vm swapButtonPressed];
            [[expectFutureValue(futureButtonImage) shouldEventually] equal:@"icon.pinlist"];
        });

    });
SPEC_END