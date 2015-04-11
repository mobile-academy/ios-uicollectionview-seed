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

        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];

        self.snapBehaviors = [NSMutableDictionary dictionary];
        self.selectedIndexPaths = [NSMutableArray array];
    }

    return self;
}

- (void)recalculateBehaviorsForSelectedIndexPaths {
    [self.selectedIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *currentAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self removeBehaviorForIndexPath:indexPath];

        NSUInteger index = [self.selectedIndexPaths indexOfObject:indexPath];
        CGPoint snapPoint = [self centerForSelectedItemAtIndex:index];

        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:currentAttributes
                                                                snapToPoint:snapPoint];

        self.snapBehaviors[indexPath] = snapBehavior;
        [self.dynamicAnimator addBehavior:snapBehavior];
    }];
}

- (void)updateSelectionForIndexPath:(NSIndexPath *)indexPath {
    BOOL selected = [self.collectionView.indexPathsForSelectedItems containsObject:indexPath];

    UICollectionViewLayoutAttributes *currentAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *flowLayoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];

    if (selected) {
        [self.selectedIndexPaths addObject:indexPath];
        [self recalculateBehaviorsForSelectedIndexPaths];
    } else {
        [self removeBehaviorForIndexPath:indexPath];
        [self.selectedIndexPaths removeObject:indexPath];

        [self recalculateBehaviorsForSelectedIndexPaths];

        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:currentAttributes
                                                                snapToPoint:flowLayoutAttributes.center];
        self.snapBehaviors[indexPath] = snapBehavior;
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
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
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (NSArray *)modifiedLayoutAttributesInRect:(CGRect)rect {
    return [self.dynamicAnimator itemsInRect:rect];
}

- (BOOL)shouldUseModifiedLayoutAttributesForIndexPath:(NSIndexPath *)indexPath {
    return [self.snapBehaviors.allKeys containsObject:indexPath];
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