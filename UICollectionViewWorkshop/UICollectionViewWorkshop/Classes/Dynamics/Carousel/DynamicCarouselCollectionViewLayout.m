/*
 * Copyright (c) 2015 Mobile Academy. All rights reserved.
 */

#import "DynamicCarouselCollectionViewLayout.h"


@interface DynamicCarouselCollectionViewLayout ()

@property(nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property(nonatomic) BOOL ignoreDynamicAnimator;

@end

@implementation DynamicCarouselCollectionViewLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(300, 250);
        self.interItemSpace = 50;

        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    }

    return self;
}

- (void)prepareLayout {
    self.ignoreDynamicAnimator = YES;

    [super prepareLayout];

    CGSize contentSize = self.collectionViewContentSize;
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0.0f, 0.0f, contentSize.width, contentSize.height)];

    if (self.dynamicAnimator.behaviors.count == 0) {
        [items enumerateObjectsUsingBlock:^(id <UIDynamicItem> item, NSUInteger idx, BOOL *stop) {
            UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item
                                                                                 attachedToAnchor:[item center]];

            attachmentBehavior.length = 0.0f;
            attachmentBehavior.damping = 0.8f;
            attachmentBehavior.frequency = 1.0f;

            [self.dynamicAnimator addBehavior:attachmentBehavior];
        }];
    }

    self.ignoreDynamicAnimator = NO;
}

#pragma mark -

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    if (self.ignoreDynamicAnimator) {
        return [super layoutAttributesForElementsInRect:rect];
    } else {
        return [self.dynamicAnimator itemsInRect:rect];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ignoreDynamicAnimator) {
        return [super layoutAttributesForItemAtIndexPath:indexPath];
    } else {
        return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
    }
}

#pragma mark - 

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    self.ignoreDynamicAnimator = YES;

    CGPoint offset = [super targetContentOffsetForProposedContentOffset:proposedContentOffset
                                                  withScrollingVelocity:velocity];

    self.ignoreDynamicAnimator = NO;

    return offset;
}

#pragma mark -

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGFloat delta = newBounds.origin.x - self.collectionView.bounds.origin.x;
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];

    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIDynamicBehavior *behavior, NSUInteger idx, BOOL *stop) {
        if ([behavior isKindOfClass:[UIAttachmentBehavior class]]) {
            UIAttachmentBehavior *springBehaviour = (UIAttachmentBehavior *) behavior;

            CGFloat xDistanceFromTouch = fabsf(touchLocation.x - springBehaviour.anchorPoint.x);
            CGFloat scrollResistance = xDistanceFromTouch / 1500.0f;

            UICollectionViewLayoutAttributes *item = springBehaviour.items.firstObject;

            CGPoint center = item.center;
            center.x += delta * scrollResistance;
            item.center = center;

            [self.dynamicAnimator updateItemUsingCurrentState:item];
        }
    }];

    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

@end