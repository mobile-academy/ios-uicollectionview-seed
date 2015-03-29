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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Switch"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(switchLayouts)];
}

- (void)switchLayouts {
    UICollectionView *collectionView = (UICollectionView *) self.view;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) collectionView.collectionViewLayout;
    BOOL isHorizontalLayout = flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal;
    UICollectionViewLayout *toLayout = isHorizontalLayout
            ? [UICollectionViewFlowLayout speakersVerticalLayout]
            : [UICollectionViewFlowLayout speakersHorizontalLayout];

    collectionView.pagingEnabled = !isHorizontalLayout;
    [collectionView setCollectionViewLayout:toLayout animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size;

    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) collectionViewLayout;
    BOOL isHorizontalLayout = flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal;
    if (isHorizontalLayout) {
        CGFloat width = CGRectGetWidth(collectionView.bounds);
        CGFloat height = CGRectGetHeight(collectionView.bounds) - collectionView.contentInset.top - collectionView.contentInset.bottom;
        size = CGSizeMake(width, height);
    } else {
        CGFloat width = CGRectGetWidth(collectionView.bounds) * 0.5f;
        size = CGSizeMake(width, width);
    }

    CGFloat margin = 20.f;
    return CGSizeMake(size.width - margin, size.height - margin);
}

@end
