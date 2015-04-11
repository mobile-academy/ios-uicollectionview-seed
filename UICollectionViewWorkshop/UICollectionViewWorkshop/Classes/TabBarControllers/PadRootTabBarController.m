/*
 * Copyright (c) 2015 Mobile Academy. All rights reserved.
 */
#import "PadRootTabBarController.h"
#import "CarouselViewController.h"
#import "UINavigationController+Utilities.h"
#import "DynamicsPlaygroundViewController.h"
#import "DynamicsPlaygroundViewController+Factory.h"
#import "DynamicCarouselCollectionViewController.h"
#import "DynamicCarouselCollectionViewController+Factory.h"


@implementation PadRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = @[
            [DynamicCarouselCollectionViewController dynamicCarouselCollectionViewController],
            [DynamicsPlaygroundViewController dynamicsPlaygroundViewController]
    ];
}

@end
