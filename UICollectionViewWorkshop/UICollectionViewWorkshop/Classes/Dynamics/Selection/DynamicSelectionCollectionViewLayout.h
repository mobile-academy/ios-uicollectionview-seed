/*
 * Copyright (c) 2015 Mobile Academy. All rights reserved.
 */

#import <Foundation/Foundation.h>


@interface DynamicSelectionCollectionViewLayout : UICollectionViewFlowLayout

- (void)updateSelectionForIndexPath:(NSIndexPath *)indexPath;

- (void)cleanupForIndexPath:(NSIndexPath *)indexPath;

@end