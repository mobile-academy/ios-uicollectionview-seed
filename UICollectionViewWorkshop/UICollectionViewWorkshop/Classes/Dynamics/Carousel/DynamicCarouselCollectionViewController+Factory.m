//
// Created by Robert Wijas on 11/04/15.
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

#import "DynamicCarouselCollectionViewController+Factory.h"


@implementation DynamicCarouselCollectionViewController (Factory)

+ (instancetype)dynamicCarouselCollectionViewController {
    DynamicCarouselCollectionViewController *viewController = [[DynamicCarouselCollectionViewController alloc] init];

    viewController.title = @"Dynamic Carousel";
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:viewController.title
                                                              image:[UIImage imageNamed:@"Hand"]
                                                                tag:6];

    return viewController;
}

@end