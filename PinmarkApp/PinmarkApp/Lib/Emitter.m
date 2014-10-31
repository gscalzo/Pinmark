//
// Created by Giordano Scalzo on 02/07/2014.
// Copyright (c) 2014 Effective code. All rights reserved.
//

#import "Emitter.h"
#import "NSDictionary+ObjectiveSugar.h"

@interface Emitter ()

@property(nonatomic, strong) NSMutableDictionary *observersSuccess;
@property(nonatomic, strong) NSMutableDictionary *observersError;

@end

@implementation Emitter

- (id)init
{
    if(self = [super init]) {
        self.observersSuccess = [@{}mutableCopy ];
        self.observersError = [@{}mutableCopy ];
    }
    return self;
}

- (void)subscribe:(id)observer on:(void (^)())observerBlock {
    self.observersSuccess[@([observer hash])] = [observerBlock copy];
}

- (void)on:(id)observer onError:(void (^)(NSError *))observerErrorBlock {
    self.observersError[@([observer hash])] = [observerErrorBlock copy];
}

- (void)emit {
    [self.observersSuccess each:^(id key, void(^observerBlock)()) {
        dispatch_async(dispatch_get_main_queue(), ^{
            observerBlock();
        });
    }];
}

- (void)emitError:(NSError *)error {
    [self.observersError each:^(id key, void(^observerBlock)(NSError *error)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            observerBlock(error);
        });
    }];
}

- (void)unsubscribe:(id)observer {
    [self.observersSuccess removeObjectForKey:@([observer hash])];
    [self.observersError removeObjectForKey:@([observer hash])];
}

@end