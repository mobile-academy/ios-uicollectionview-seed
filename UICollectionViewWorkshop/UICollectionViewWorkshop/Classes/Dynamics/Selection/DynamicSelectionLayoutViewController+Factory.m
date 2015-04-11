/*
 * Copyright (c) 2015 Mobile Academy. All rights reserved.
 */

#import "DynamicSelectionLayoutViewController+Factory.h"


@implementation DynamicSelectionLayoutViewController (Factory)

+ (instancetype)selectionFlowLayoutExampleViewController {
    DynamicSelectionLayoutViewController *controller = [[DynamicSelectionLayoutViewController alloc] init];

    controller.edgesForExtendedLayout = UIRectEdgeNone;

    controller.title = @"Selection";
    controller.tabBarItem = [[UITabBarItem alloc] initWithTitle:controller.title
                                                          image:[UIImage imageNamed:@"Camera"]
                                                            tag:5];

    return controller;
}

@end