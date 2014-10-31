//
// Created by Giordano Scalzo on 31/10/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "ContainerViewModel.h"
#import "Emitter.h"


@implementation ContainerViewModel
- (instancetype)initWithEmitter:(id)emitter {
    self = [super init];
    if (self) {
        self.emitter = emitter;
    }

    return self;
}

+ (instancetype)modelWithEmitter:(id)emitter {
    return [[self alloc] initWithEmitter:emitter];
}


- (void)swapButtonPressed{
    self.childVCIndexToShow = (self.childVCIndexToShow + 1)%2;
    [self.emitter emit];
}

@end