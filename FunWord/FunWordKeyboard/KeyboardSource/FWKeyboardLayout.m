//
//  FWKeyboardLayout.m
//  FunWord
//
//  Created by admin on 15-1-12.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "FWKeyboardLayout.h"
#import "FWKeyboardManager.h"

@implementation FWKeyboardLayout
-(void)prepareLayout{
    [super prepareLayout];
}

-(CGSize)collectionViewContentSize{
    return self.collectionView.frame.size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    NSLog(@">>>>%@",layoutAttributes);
    return layoutAttributes;
}


- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    [self applyLayoutAttributes:layoutAttributes];
    return layoutAttributes;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes
{
    FWKey *key = [self.keyItems objectAtIndex:attributes.indexPath.row];
    attributes.size = key.viewRect.size;
    attributes.frame = key.viewRect;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
//{
//    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path]; //生成空白的attributes对象，其中只记录了类型是cell以及对应的位置是indexPath
//    //配置attributes到圆周上
//    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
//    attributes.center = CGPointMake(_center.x + _radius * cosf(2 * path.item * M_PI / _cellCount), _center.y + _radius * sinf(2 * path.item * M_PI / _cellCount));
//    return attributes;
//}

- (NSArray *)indexPathsOfItemsInRect:(CGRect) rect
{
    // For the purposes of this CollectionView, all items are always visible.
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSUInteger sections = [self.collectionView numberOfSections];
    
    for (NSUInteger section = 0; section < sections; section++) {
        for (NSInteger row = 0; row < [self.collectionView numberOfItemsInSection:section]; row++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:row inSection:section]];
        }
    }
    
    return indexPaths;
}


@end
