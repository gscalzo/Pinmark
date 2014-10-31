//
//  ContainerViewController.m
//  Container Transitions
//
//  Created by Joachim Bondo on 30/04/2014.
//

#import "ContainerViewController.h"
#import "ContainerViewModel.h"
#import "Emitter.h"
#import "Common.h"

static CGFloat const kButtonSlotWidth = 64; // Also distance between button centers
static CGFloat const kButtonSlotHeight = 44;

@interface ContainerViewController ()
@property (nonatomic, copy, readwrite) NSArray *viewControllers;
@property (nonatomic, strong) UIView *privateButtonsView; /// The view hosting the buttons of the child view controllers.
@property (nonatomic, strong) UIView *privateContainerView; /// The view hosting the child view controllers views.
@property(nonatomic, strong) ContainerViewModel *vm;

@end

@implementation ContainerViewController

- (instancetype)initWithViewControllers:(NSArray *)viewControllers viewModel:(ContainerViewModel *)vm {
    NSParameterAssert ([viewControllers count] > 0);
    if ((self = [super init])) {
        self.viewControllers = [viewControllers copy];
        self.vm = vm;
    }
    return self;
}

- (void)loadView {

    // Add  container and buttons views.

    UIView *rootView = [[UIView alloc] init];
    rootView.backgroundColor = [UIColor blackColor];
    rootView.opaque = YES;

    self.privateContainerView = [[UIView alloc] init];
    self.privateContainerView.backgroundColor = [UIColor blackColor];
    self.privateContainerView.opaque = YES;

    self.privateButtonsView = [[UIView alloc] init];
    self.privateButtonsView.backgroundColor = [UIColor clearColor];

    [self.privateContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.privateButtonsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [rootView addSubview:self.privateContainerView];
    [rootView addSubview:self.privateButtonsView];

    // Container view fills out entire root view.
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];

    // Place buttons view in the top half, horizontally centered.
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kButtonSlotWidth]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.privateContainerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kButtonSlotHeight]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.privateContainerView attribute:NSLayoutAttributeCenterY multiplier:0.4f constant:0]];

    [self _addChildViewControllerButtons];

    self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedViewController = (self.selectedViewController ?: self.viewControllers[0]);

    [self render];
    WSELFY
    [self.vm.emitter subscribe:self on:^{
        [weakSelf render];
    }];
}

- (void)dealloc{
    [self.vm.emitter unsubscribe:self];
}


-(void)setSelectedViewController:(UIViewController *)selectedViewController {
    NSParameterAssert (selectedViewController);
    [self _transitionToChildViewController:selectedViewController];
    _selectedViewController = selectedViewController;
}

#pragma mark Private Methods

- (void)_addChildViewControllerButtons {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"AAAA" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(_buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.privateButtonsView addSubview:button];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.privateButtonsView
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1 constant:0]];
    [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.privateButtonsView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1 constant:0]];
    [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.privateButtonsView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:1 constant:0]];
    [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.privateButtonsView
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1 constant:0]];
}

- (void)_buttonTapped:(UIButton *)button {
    [self.vm swapButtonPressed];
}

- (void)_transitionToChildViewController:(UIViewController *)toViewController {

    UIViewController *fromViewController = ([self.childViewControllers count] > 0 ? self.childViewControllers[0] : nil);
    if (toViewController == fromViewController || ![self isViewLoaded]) {
        return;
    }

    UIView *toView = toViewController.view;
    [toView setTranslatesAutoresizingMaskIntoConstraints:YES];
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame = self.privateContainerView.bounds;

    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    [self.privateContainerView addSubview:toView];
    [fromViewController.view removeFromSuperview];
    [fromViewController removeFromParentViewController];
    [toViewController didMoveToParentViewController:self];
}

#pragma mark - Render

- (void)render {
    UIViewController *selectedViewController = self.viewControllers[(NSUInteger) self.vm.childVCIndexToShow];
    self.selectedViewController = selectedViewController;
}


@end