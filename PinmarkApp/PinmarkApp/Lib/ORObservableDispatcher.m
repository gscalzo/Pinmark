//
// Created by Giordano Scalzo on 02/07/2014.
// Copyright (c) 2014 Effective code. All rights reserved.
//

#import "ORObservableDispatcher.h"
#import "NSDictionary+ObjectiveSugar.h"

@interface ORObservableDispatcher ()

@property(nonatomic, strong) NSMutableDictionary *observersSuccess;
@property(nonatomic, strong) NSMutableDictionary *observersError;

@end

@implementation ORObservableDispatcher

- (id)init
{
    if(self = [super init]) {
        self.observersSuccess = [@{}mutableCopy ];
        self.observersError = [@{}mutableCopy ];
    }
    return self;
}

- (void)observer:(id)observer observerBlock:(void (^)())observerBlock {
    self.observersSuccess[@([observer hash])] = [observerBlock copy];
}

- (void)observer:(id)observer observerErrorBlock:(void (^)(NSError *))observerErrorBlock {
    self.observersError[@([observer hash])] = [observerErrorBlock copy];
}

- (void)update {
    [self.observersSuccess each:^(id key, void(^observerBlock)()) {
        dispatch_async(dispatch_get_main_queue(), ^{
            observerBlock();
        });
    }];
}

- (void)updateError:(NSError *)error {
    [self.observersError each:^(id key, void(^observerBlock)(NSError *error)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            observerBlock(error);
        });
    }];
}

- (void)unobserve:(id)observer {
    [self.observersSuccess removeObjectForKey:@([observer hash])];
    [self.observersError removeObjectForKey:@([observer hash])];
}

@end