/*
 * Copyright (c) 2015 Mobile Academy. All rights reserved.
 */

#import "DynamicCarouselCollectionViewLayout.h"


@implementation DynamicCarouselCollectionViewLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(300, 250);
        self.interItemSpace = 50;

        // TODO 1: Create dynamic animator for current layout.
    }

    return self;
}

- (void)prepareLayout {
    [super prepareLayout];

    // TODO 2: Create attachment behavior for every item and add it to dynamic animator.
    // Hints:
    // 1. Use item.center calculated by superclass to for attachment's anchor point.
    // 2. Setup behaviours only once (simplified solution that assumes our items collection doesn't change).
    // 3. Suggested initial values for attachment's properties: length: 0, damping: 0.8, frequency: 1.0.



    // TODO 4: Disable the use of dynamics animator when layout gets prepared.
}

#pragma mark -

// TODO 3: Use dynamic animator to return layout attributes.
// Hints:
// 1. Override layoutAttributesForElementsInRect: and layoutAttributesForItemAtIndexPath: methods.

#pragma mark -

// TODO 5: Fix target offset.
// Hint: Override the method and use the same trick we use in prepareLayout to ignore dynamic animator
//       when target content offset is calculated.


#pragma mark -

// TODO 6: Add scrolling resistance.

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    // For each item correct its position by moving it slightly in the direction opposite to scrolling direction.

    // Hints:
    // 1. Position correction should be based on bounds change and the distance between the touch and the original position of the item.
    //    center.x change = (bounds change) * (item distance from the touch / coefficient(start with 1500)).
    // 2. Get the touch position from collection view's pan gesture recognizer.
    // 3. Get the final position of the item from its attachment behavior.
    // 4. Remember to tell the animator that you've changed the item's state.

    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

@end