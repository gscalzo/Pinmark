//
//  MapViewController.m
//  PinmarkApp
//
//  Created by Giordano Scalzo on 31/10/14.
//  Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

#import "MapViewController.h"
#import "Masonry.h"
#import "MapViewModel.h"
#import "Emitter.h"
#import "Common.h"
#import <MapKit/MapKit.h>


@interface MapViewController ()
@property(nonatomic, strong) MKMapView *mapView;
@property(nonatomic, strong) MapViewModel *vm;

@end

@implementation MapViewController

- (instancetype)initWithVm:(MapViewModel *)vm {
    self = [super init];
    if (self) {
        self.vm = vm;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];

    self.mapView = [MKMapView new];
    [self.view addSubview:self.mapView];
    [self layoutView];

    WSELFY
    [self render];
    [self.vm.emitter subscribe:self on:^{
        [weakSelf render];
    }];

}

- (void)dealloc {
    [self.vm.emitter unsubscribe:self];
}

#pragma mark - Layout

- (void)layoutView {
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - Render

- (void)render {
    if (self.vm.coordinate.latitude != 0 &&
            self.vm.coordinate.longitude != 0) {
        MKCoordinateSpan span = MKCoordinateSpanMake(self.vm.spanLat, self.vm.spanLong);
        MKCoordinateRegion region = {self.vm.coordinate, span};
        self.mapView.region = region;
    }
}

@end
