//
//  AppDelegate.m
//  PinmarkApp
//
//  Created by Giordano Scalzo on 30/10/14.
//  Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//


#import "AppDelegate.h"
#import "ContainerViewController.h"
#import "MapViewController.h"
#import "PinListViewController.h"
#import "ContainerViewModel.h"
#import "MapViewModel.h"
#import "LocationDatastore.h"


@interface AppDelegate ()
@property(nonatomic, strong) UIWindow *privateWindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.privateWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.privateWindow.rootViewController = [self _configuredRootViewController];
    [self.privateWindow makeKeyAndVisible];

    return YES;
}

#pragma mark - Private Methods

- (UIViewController *)_configuredRootViewController {

    NSArray *childViewControllers = [self _configuredChildViewControllers];
    ContainerViewController *rootViewController = [[ContainerViewController alloc] initWithViewControllers:childViewControllers viewModel:[ContainerViewModel new]];

    return rootViewController;
}

- (NSArray *)_configuredChildViewControllers {

    return @[
            [[MapViewController alloc] initWithVm:[[MapViewModel alloc] initWithLocationManager:[LocationDatastore new]]],
            [PinListViewController new]
    ];
}


@end