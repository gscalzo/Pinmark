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
            ContainerViewModel *vm = [ContainerViewModel modelWithEmitter:[Emitter new]];
            [[vm.emitter should] beNonNil];
        });

        it(@"should start having childVC at index 0 to show", ^{
            ContainerViewModel *vm = [ContainerViewModel modelWithEmitter:[Emitter new]];
            [theValue(vm.childVCIndexToShow) isEqual:theValue(0)];
        });


        it(@"should have an action to change the index to 1", ^{
            Emitter *emitter = [Emitter new];
            ContainerViewModel *vm = [ContainerViewModel modelWithEmitter:emitter];

            __block NSInteger futureChildIndex = -1;
            [vm.emitter subscribe:self on:^{
                futureChildIndex = vm.childVCIndexToShow;
            }];

            [vm swapButtonPressed];
            [[expectFutureValue(theValue(futureChildIndex)) shouldEventually] equal:theValue(1)];
        });

        it(@"should alternate the value of the child to show", ^{
            Emitter *emitter = [Emitter new];
            ContainerViewModel *vm = [ContainerViewModel modelWithEmitter:emitter];

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


    });
SPEC_END