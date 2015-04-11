/*
 * Copyright (c) 2015 Mobile Academy. All rights reserved.
 */

#import "DynamicSelectionLayoutViewController.h"
#import "DynamicSelectionCollectionViewLayout.h"
#import "DynamicSelectionCollectionViewCell.h"


@implementation DynamicSelectionLayoutViewController

- (id)init {
    DynamicSelectionCollectionViewLayout *layout = [[DynamicSelectionCollectionViewLayout alloc] init];

    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.collectionView.allowsMultipleSelection = YES;
    }

    return self;
}

- (DynamicSelectionCollectionViewLayout *)selectionLayout {
    return (DynamicSelectionCollectionViewLayout *) self.collectionViewLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[DynamicSelectionCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.collectionViewLayout invalidateLayout];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 35;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DynamicSelectionCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                                                    forIndexPath:indexPath];
    cell.label.text = [@(indexPath.row) stringValue];
    [self updateAccordingToSelectionWithCell:cell animated:NO];

    return cell;
}

- (void)updateAccordingToSelectionWithCell:(UICollectionViewCell *)cell animated:(BOOL)animated {
    void (^animations)() = ^{
        cell.layer.shadowColor = [UIColor whiteColor].CGColor;
        cell.layer.shadowOffset = CGSizeZero;
        cell.layer.shadowRadius = 10;
        cell.layer.shadowOpacity = cell.selected ? 1.0f : 0.0f;
    };

    if (animated) {
        [UIView animateWithDuration:0.3 animations:animations];
    } else {
        animations();
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectionChangedForIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectionChangedForIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectionLayout cleanupForIndexPath:indexPath];
}

- (void)selectionChangedForIndexPath:(NSIndexPath *)indexPath {
    [self.selectionLayout updateSelectionForIndexPath:indexPath];

    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    [self updateAccordingToSelectionWithCell:cell animated:YES];
}

@end