/*
 * Copyright (c) 2015 Mobile Academy. All rights reserved.
 */

#import "DynamicSelectionCollectionViewLayout.h"


@interface DynamicSelectionCollectionViewLayout ()

@property(nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property(nonatomic, strong) NSMutableDictionary *snapBehaviors;

@property(nonatomic, strong) NSMutableArray *selectedIndexPaths;

@end

@implementation DynamicSelectionCollectionViewLayout

- (id)init {
    self = [super init];

    if (self) {
        self.sectionInset = UIEdgeInsetsMake(20, 20, 20, 200);
        self.itemSize = CGSizeMake(100, 100);

        // TODO 1: Create dynamic animator.

        self.snapBehaviors = [NSMutableDictionary dictionary];
        self.selectedIndexPaths = [NSMutableArray array];
    }

    return self;
}

- (void)recalculateBehaviorsForSelectedIndexPaths {
    [self.selectedIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *currentAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];

        // TODO 3.2: Add snap behaviors for all selected items.
        // Hints:
        // 1. Use centerForSelectedItemAtIndex: as a snap point.
        // 2. Use removeBehaviorForIndexPath: to remove old behavior before creating a new one.
    }];
}

- (void)updateSelectionForIndexPath:(NSIndexPath *)indexPath {
    // TODO 3.1: Update behaviors.
    // Hints:
    // 1. If item is not selected make sure to remove its behavior with removeBehaviorForIndexPath:.
    // 2. Use recalculateBehaviorsForSelectedIndexPaths method.

    BOOL selected = [self.collectionView.indexPathsForSelectedItems containsObject:indexPath];

    if (selected) {
        // TODO 3.1: Here!

        [self.selectedIndexPaths addObject:indexPath];
    } else {
        // TODO 3.1: And here!

        [self.selectedIndexPaths removeObject:indexPath];

        // TODO 4: Add behavior to snap back when deselected.
        // Hints:
        // 1. Store attributes before deselecting the item
        //    and add snap behavior with snap point based on center from attributes
        //    returned from flow layout superclass.
    }

    [self invalidateLayout];
}

#pragma mark - Overrides

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *result = [NSMutableArray array];

    for (UICollectionViewLayoutAttributes *attributes in [super layoutAttributesForElementsInRect:rect]) {
        if (![self shouldUseModifiedLayoutAttributesForIndexPath:attributes.indexPath]) {
            [result addObject:attributes];
        }
    }

    [result addObjectsFromArray:[self modifiedLayoutAttributesInRect:rect]];

    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self shouldUseModifiedLayoutAttributesForIndexPath:indexPath]) {
        return [self modifiedLayoutAttributesAtIndexPath:indexPath];
    } else {
        return [super layoutAttributesForItemAtIndexPath:indexPath];
    }
}

#pragma mark - Modifications

- (UICollectionViewLayoutAttributes *)modifiedLayoutAttributesAtIndexPath:(NSIndexPath *)indexPath {
    // TODO 2.1: use dynamic animator to get modified attributes

    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];

    NSUInteger index = [self.selectedIndexPaths indexOfObject:indexPath];
    layoutAttributes.center = [self centerForSelectedItemAtIndex:index];

    return layoutAttributes;
}

- (NSArray *)modifiedLayoutAttributesInRect:(CGRect)rect {
    // TODO 2.2: use dynamic animator to get modified attributes

    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (NSIndexPath *indexPath in self.selectedIndexPaths) {
        [result addObject:[self modifiedLayoutAttributesAtIndexPath:indexPath]];
    }

    return result.copy;
}

- (BOOL)shouldUseModifiedLayoutAttributesForIndexPath:(NSIndexPath *)indexPath {
    // TODO 3.3: YES if we have a behavior for this index path

    return [self.selectedIndexPaths containsObject:indexPath];
}

#pragma mark - Calculations

- (CGPoint)centerForSelectedItemAtIndex:(NSUInteger)index {
    CGPoint center = CGPointZero;

    center.x = self.collectionView.bounds.size.width - self.sectionInset.left - self.itemSize.width * 0.5f;
    center.y = self.sectionInset.top + self.itemSize.height * 0.5f + (self.minimumLineSpacing + self.itemSize.height) * index;

    return center;
}

- (CGSize)collectionViewContentSize {
    CGSize contentSize = [super collectionViewContentSize];

    NSIndexPath *lastSelectedIndexPath = self.selectedIndexPaths.lastObject;
    if (lastSelectedIndexPath) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:lastSelectedIndexPath];

        CGFloat maxY = attributes.center.y + attributes.bounds.size.height * 0.5f + self.sectionInset.bottom;
        contentSize.height = MAX(contentSize.height, maxY);
    }

    return contentSize;
}

#pragma mark - Behaviours Helper Methods

- (void)cleanupForIndexPath:(NSIndexPath *)indexPath {
    if (![self.collectionView.indexPathsForSelectedItems containsObject:indexPath]) {
        [self removeBehaviorForIndexPath:indexPath];
    }
}

- (void)removeBehaviorForIndexPath:(NSIndexPath *)indexPath {
    UISnapBehavior *snapBehavior = self.snapBehaviors[indexPath];
    if (snapBehavior) {
        [self.dynamicAnimator removeBehavior:snapBehavior];
        [self.snapBehaviors removeObjectForKey:indexPath];
    }
}

@end