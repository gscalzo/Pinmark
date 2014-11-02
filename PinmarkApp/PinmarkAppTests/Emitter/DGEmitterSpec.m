//
//  DGEmitterSpec.m
//  Delhaize
//
//  Created by Giordano Scalzo on 01/07/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//
#import "Kiwi.h"
#import "ObserverInTest.h"
#import "Emitter.h"

SPEC_BEGIN(DGEmitterSpec)
    describe(@"Emitter", ^{

        __block Emitter *emitter = nil;
        __block ObserverInTest *observer1 = nil;
        __block ObserverInTest *observer2 = nil;

        beforeEach(^{
            emitter = [Emitter new];

            observer1 = [ObserverInTest new];
            [emitter subscribe:observer1 on:^{
                observer1.successCounter += 1;
            }];
            [emitter on:observer1 onError:^(NSError *error) {
                observer1.errorCounter += 1;
            }];

            observer2 = [ObserverInTest new];
            [emitter subscribe:observer2 on:^{
                observer2.successCounter += 1;
            }];
            [emitter on:observer2 onError:^(NSError *error) {
                observer2.errorCounter += 1;
            }];
        });

        it(@"updates all registered observersSuccess", ^{
            [emitter emit];
            [[expectFutureValue(theValue(observer1.successCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.successCounter)) shouldEventually] equal:theValue(1)];
        });

        it(@"updates only registered observersSuccess", ^{
            [emitter emit];
            [[expectFutureValue(theValue(observer1.successCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.successCounter)) shouldEventually] equal:theValue(1)];

            [emitter unsubscribe:observer1];
            [emitter emit];
            [[expectFutureValue(theValue(observer1.successCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.successCounter)) shouldEventually] equal:theValue(2)];
        });

        it(@"handles wrong unobserve actions", ^{
            [emitter unsubscribe:nil];
            [emitter unsubscribe:[ObserverInTest new]];
            [emitter emit];
            [[expectFutureValue(theValue(observer1.successCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.successCounter)) shouldEventually] equal:theValue(1)];
        });


        it(@"error updates error registered observersSuccess", ^{
            [emitter emitError:nil];
            [[expectFutureValue(theValue(observer1.errorCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.errorCounter)) shouldEventually] equal:theValue(1)];
        });

        it(@"updates for error only registered observersSuccess", ^{
            [emitter emitError:nil];
            [[expectFutureValue(theValue(observer1.errorCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.errorCounter)) shouldEventually] equal:theValue(1)];

            [emitter unsubscribe:observer1];
            [emitter emitError:nil];
            [[expectFutureValue(theValue(observer1.errorCounter)) shouldEventually] equal:theValue(1)];
            [[expectFutureValue(theValue(observer2.errorCounter)) shouldEventually] equal:theValue(2)];
        });
    });


SPEC_END


#pragma clang diagnostic pop