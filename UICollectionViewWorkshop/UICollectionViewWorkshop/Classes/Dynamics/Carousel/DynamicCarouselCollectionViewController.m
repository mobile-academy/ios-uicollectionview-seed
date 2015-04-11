/*
 * Copyright (c) 2015 Mobile Academy. All rights reserved.
 */

#import "DynamicCarouselCollectionViewController.h"
#import "DynamicCarouselCollectionViewLayout.h"

@implementation DynamicCarouselCollectionViewController

- (id)init {
    DynamicCarouselCollectionViewLayout *layout = [[DynamicCarouselCollectionViewLayout alloc] init];

    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // init
    }

    return self;
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor lightGrayColor];

    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    cell.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];

    return cell;
}

@end