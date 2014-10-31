//
// Created by Giordano Scalzo on 02/07/2014.
// Copyright (c) 2014 Effective code. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ORObservableDispatcher : NSObject

- (void)observer:(id)observer observerBlock:(void (^)())observerBlock;
- (void)observer:(id)observer observerErrorBlock:(void (^)(NSError *))observerErrorBlock;

- (void)update;

- (void)unobserve:(id)observer;

- (void)updateError:(NSError *)error;
@end