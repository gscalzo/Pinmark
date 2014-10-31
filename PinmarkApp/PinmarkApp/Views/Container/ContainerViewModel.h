//
// Created by Giordano Scalzo on 31/10/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ContainerViewModel : NSObject
@property(nonatomic, strong) id emitter;

- (instancetype)initWithEmitter:(id)emitter;

+ (instancetype)modelWithEmitter:(id)emitter;

@end