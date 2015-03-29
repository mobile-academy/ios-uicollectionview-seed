//
// Created by Maciej Oczko on 26/03/15.
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

#import "SpeakersViewController.h"
#import "SpeakersDataSource.h"
#import "UICollectionViewFlowLayout+SpeakersLayouts.h"

@interface SpeakersViewController () <UICollectionViewDelegateFlowLayout>
@end

@implementation SpeakersViewController

/*
    This is a view controller for managing collection view.
    It takes `SpeakersDataSource` as a dependency to provide items for collection view.

    Please follow the TODOs to complete this exercise.
    (To list TODOs in AppCode use CMD+6 shortcut.)

    HINT 1: Only this file need to be changed.
    HINT 2: Implement `-switchLayouts` and `-sizeForItemAtIndexPath:` methods. See TODOs.
 */
+ (instancetype)withDataSource:(SpeakersDataSource *)dataSource {
    return [[self alloc] initWithDataSource:dataSource];
}

- (instancetype)initWithDataSource:(SpeakersDataSource *)dataSource {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _dataSource = dataSource;
        self.title = @"Speakers";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title
                                                        image:[UIImage imageNamed:@"Speakers"]
                                                          tag:1];
    }

    return self;
}

- (void)loadView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout speakersVerticalLayout];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                          collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    [self.dataSource bindWithCollectionView:collectionView];
    self.view = collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // TODO 1. Create UIBarButtonItem for rightBarButtonItem for `-switchLayoutSelector`
}

- (void)switchLayouts {
    // TODO 2. You have to toggle between 2 flow layouts
    // first: `speakersVerticalLayout` and second `speakersHorizontalLayout` (See _UICollectionViewFlowLayout+SpeakersLayouts_ file for definitions)
    //
    // HINT 1. You can test `scrollDirection` property of flow layout to determine which layout should be applied.
    // HINT 2. To apply layout call `-setCollectionViewLayout:animated` on collection view.
    // HINT 3. You can enable paging (`-pagingEnabled`) on collection view for horizontal layout
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    // TODO 3. You have to calculate different sizes for vertical and horizontal layout
    // HINT 1: Vertical cell size remains the same.

    // Uncomment following code and implement.

//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) collectionViewLayout;
//    BOOL isHorizontalLayout = flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal;
//    if (isHorizontalLayout) {
//
//    } else {
//
//    }

    CGFloat margin = 20.f;
    return CGSizeMake(size.width - margin, size.height - margin);
}

@end
