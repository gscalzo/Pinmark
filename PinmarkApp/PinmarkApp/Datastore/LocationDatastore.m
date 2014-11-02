//
// Created by Giordano Scalzo on 01/11/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "LocationDatastore.h"
#import "Emitter.h"


@implementation LocationDatastore
- (id)init
{
    if(self = [super init]) {
        self.emitter = [Emitter new];
    }
    return self;
}


@end