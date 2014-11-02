//
// Created by Giordano Scalzo on 31/10/14.
// Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "ContainerViewModel.h"
#import "Emitter.h"


@implementation ContainerViewModel

- (id)init
{
    if(self = [super init]) {
        self.emitter = [Emitter new];
        [self setupButtonImage];
    }
    return self;
}

- (void)swapButtonPressed{
    self.childVCIndexToShow = (self.childVCIndexToShow + 1)%2;
    [self setupButtonImage];
    [self.emitter emit];
}

- (void)setupButtonImage {
    self.buttonImage = self.childVCIndexToShow == 0 ? @"icon.pinlist" : @"icon.map";
}

@end