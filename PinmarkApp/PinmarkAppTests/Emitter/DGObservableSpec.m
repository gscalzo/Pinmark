//
//  DGObservableSpec.m
//  Delhaize
//
//  Created by Giordano Scalzo on 01/07/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//
#import "Kiwi.h"
#import "ObserverInTest.h"
#import "ORObservableDispatcher.h"

SPEC_BEGIN(DGObservableSpec)
    describe(@"ORObservable", ^{

        __block ORObservableDispatcher *observable = nil;
        __block ObserverInTest *observer1 = nil;
        __block ObserverInTest *observer2 = nil;

        beforeEach(^{
            observable = [ORObservableDispatcher new];

            observer1 = [ObserverInTest new];
            [observable observer:observer1 observerBlock:^{
                observer1.successCounter += 1;
            }];
            [observable observer:observer1 observerErrorBlock:^(NSError *error){
                observer1.errorCounter += 1;
            }];

            observer2 = [ObserverInTest new];
            [observable observer:observer2 observerBlock:^{
                observer2.successCounter += 1;
            }];
            [observable observer:observer2 observerErrorBlock:^(NSError *error){
                observer2.errorCounter += 1;
            }];
        });

        it(@"updates all registered observersSuccess", ^{
            [observable update];
            [[expectFutureValue(theValue(observer1.successCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.successCounter)) shouldEventually] equal:theValue(1)];
        });

        it(@"updates only registered observersSuccess", ^{
            [observable update];
            [[expectFutureValue(theValue(observer1.successCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.successCounter)) shouldEventually] equal:theValue(1)];

            [observable unobserve:observer1];
            [observable update];
            [[expectFutureValue(theValue(observer1.successCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.successCounter)) shouldEventually] equal:theValue(2)];
        });

        it(@"handles wrong unobserve actions", ^{
            [observable unobserve:nil];
            [observable unobserve:[ObserverInTest new]];
            [observable update];
            [[expectFutureValue(theValue(observer1.successCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.successCounter)) shouldEventually] equal:theValue(1)];
        });


        it(@"error updates error registered observersSuccess", ^{
            [observable updateError:nil];
            [[expectFutureValue(theValue(observer1.errorCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.errorCounter)) shouldEventually] equal:theValue(1)];
        });

        it(@"updates for error only registered observersSuccess", ^{
            [observable updateError:nil];
            [[expectFutureValue(theValue(observer1.errorCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.errorCounter)) shouldEventually] equal:theValue(1)];

            [observable unobserve:observer1];
            [observable updateError:nil];
            [[expectFutureValue(theValue(observer1.errorCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.errorCounter)) shouldEventually] equal:theValue(2)];
        });
    });


SPEC_END


#pragma clang diagnostic pop