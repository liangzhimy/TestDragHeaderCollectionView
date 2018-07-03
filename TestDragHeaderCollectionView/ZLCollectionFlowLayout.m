//
//  ZLCollectionFlowLayout.m
//  TestDragHeaderCollectionView
//
//  Created by liangzhimy on 2018/7/2.
//  Copyright © 2018年 laig. All rights reserved.
//

#import "ZLCollectionFlowLayout.h"

@implementation ZLCollectionFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (UICollectionViewScrollDirection)scrollDirection{
    return UICollectionViewScrollDirectionVertical;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    UICollectionView *collectionView = [self collectionView];
    UIEdgeInsets insets = [collectionView contentInset];
    CGPoint offset = [collectionView contentOffset];
    CGFloat minY = -insets.top;
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSLog(@"Offset : %@", NSStringFromCGPoint(offset));
    if (offset.y < minY) {
        CGSize headerSize = self.headerReferenceSize;
        CGFloat deltaY = fabs(offset.y - minY);
        for (UICollectionViewLayoutAttributes *attrs in attributes) {
            if ([attrs representedElementKind] == UICollectionElementKindSectionHeader) {
                CGRect headerRect = [attrs frame];
                headerRect.size.height = MAX(minY, headerSize.height + deltaY);
                headerRect.origin.y = headerRect.origin.y - deltaY;
                [attrs setFrame:headerRect];
                break;
            }
        }
    } else if (offset.y > minY) {
        for (UICollectionViewLayoutAttributes *attrs in attributes) {
            if ([attrs representedElementKind] == UICollectionElementKindSectionHeader) {
                CGRect headerRect = [attrs frame];
                if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
                    headerRect.origin.y = MAX(self.collectionView.contentOffset.y, headerRect.origin.y);
                }
                headerRect.size.height = 50;
                [attrs setFrame:headerRect];
                break;
            }
        }
    }
    return attributes;
}

- (CGSize)__headerReferenceSize {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}

@end
