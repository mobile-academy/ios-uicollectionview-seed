//
// Created by Robert Wijas on 11/04/15.
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

#import <Tweaks/FBTweakStore.h>
#import "DynamicsPlaygroundViewController+Factory.h"
#import "FBTweakViewController.h"
#import "_FBTweakCollectionViewController.h"


@implementation DynamicsPlaygroundViewController (Factory)

+ (UIViewController *)dynamicsPlaygroundViewController {
    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];

    FBTweakCategory *category = [[FBTweakStore sharedInstance] tweakCategoryWithName:DYNAMICS_PLAYGROUND_CATEGORY];
    _FBTweakCollectionViewController *tweakViewController = [[_FBTweakCollectionViewController alloc] initWithTweakCategory:category];

    tweakViewController.navigationItem.rightBarButtonItem = nil;

    splitViewController.viewControllers = @[tweakViewController, [[DynamicsPlaygroundViewController alloc] init]];


    splitViewController.title = @"Playground";
    splitViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:splitViewController.title
                                                                   image:[UIImage imageNamed:@"Umbrella"]
                                                                     tag:5];

    splitViewController.edgesForExtendedLayout = UIRectEdgeNone;

    return splitViewController;
}

@end