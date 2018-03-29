//
//  WYWPractiseLoopViewFlowLayout.m
//  WWCollection
//
//  Created by WYW on 2018/3/29.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWPractiseLoopViewFlowLayout.h"

@implementation WYWPractiseLoopViewFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //学习网址：https://blog.csdn.net/qq_16800895/article/details/52499673
    NSArray *layoutAttributesArray = [super layoutAttributesForElementsInRect:rect];
    for (NSInteger i = 1; i < layoutAttributesArray.count; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = layoutAttributesArray[i];
        UICollectionViewLayoutAttributes *previousLayoutAttributes = layoutAttributesArray[i - 1];
//        NSInteger maximumSpacing = 0;
        NSInteger maximumSpacing = 0;
        NSInteger origin = CGRectGetMaxX(previousLayoutAttributes.frame);
        
        if (origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
//            self.collectionView.contentSize.width
            
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return layoutAttributesArray;
}

@end
