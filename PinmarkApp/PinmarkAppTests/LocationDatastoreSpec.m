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

    });
SPEC_END