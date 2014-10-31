//
//  Common.h
//  PinmarkApp
//
//  Created by Giordano Scalzo on 31/10/14.
//  Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#ifndef PinmarkApp_Common____FILEEXTENSION___
#define PinmarkApp_Common____FILEEXTENSION___

#define WSELFY __weak typeof(self) weakSelf = self;
#define SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil


#endif
