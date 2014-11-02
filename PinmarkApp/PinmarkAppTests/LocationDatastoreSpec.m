//
// Created by Giordano Scalzo on 01/11/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "LocationDatastore.h"


SPEC_BEGIN(LocationDatastoreSpec)
    describe(@"A LocationDatastore", ^{
        it(@"should have an Emitter", ^{
            LocationDatastore *lm = [LocationDatastore new];
            [[lm.emitter should] beNonNil];
        });
    });
SPEC_END
