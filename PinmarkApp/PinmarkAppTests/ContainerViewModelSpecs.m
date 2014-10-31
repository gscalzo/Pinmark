//
//  ContainerViewModelSpecs.m
//  PinmarkApp
//
//  Created by Giordano Scalzo on 31/10/14.
//  Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "Kiwi.h"
#import "ContainerViewModel.h"
#import "Emitter.h"

SPEC_BEGIN(ContainerViewModelSpec)
    describe(@"A ContainerViewMolde", ^{
        it(@"should have an Emitter", ^{
            ContainerViewModel *vm = [ContainerViewModel modelWithEmitter:[Emitter new]];
            [[vm.emitter should] beNonNil];
        });
    });
SPEC_END