//
//  StaticHeadersCollectionViewLayout.m
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

/** Commented out code can be used to fix the top row. **/

#import "StaticHeadersCollectionViewLayout.h"

#define NUMBEROFCOLUMNS 9

@implementation StaticHeadersCollectionViewLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [@[] mutableCopy];
    for (NSArray *section in _itemAttributes) {
        [attributes addObjectsFromArray:[section filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return CGRectIntersectsRect(rect, [evaluatedObject frame]);
        }]]];
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _itemAttributes[indexPath.section][indexPath.row];
}

- (CGSize)collectionViewContentSize {
    return self.contentSize;
}

- (void)prepareLayout {
    if (self.collectionView.numberOfSections == 0) {
        return;
    }
    
    NSUInteger column = 0; // Current column inside row
    CGFloat xOffset = 0.0;
    CGFloat yOffset = 0.0;
    CGFloat contentWidth = 0.0; // To determine the contentSize
    CGFloat contentHeight = 0.0; // To determine the contentSize
    
    // Next times, the first time self.itemAttributes is equal to zero
    if (self.itemAttributes.count > 0) {
        for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
            NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            for (NSUInteger index = 0; index < numberOfItems; index++) {
                if (section != 0 && index != 0) {
                    continue;
                }
                
                UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:section]];
//                if (section == 0) {
//                    CGRect frame = attributes.frame;
//                    frame.origin.y = self.collectionView.contentOffset.y;
//                    attributes.frame = frame;
//                }
                if (index == 0) {
                    CGRect frame = attributes.frame;
                    frame.origin.x = self.collectionView.contentOffset.x;
                    attributes.frame = frame;
                }
            }
        }
        
        return;
    }
    
    // The following code is only executed the first time we prepare the layout
    self.itemAttributes = [@[] mutableCopy];
    self.itemsSize = [@[] mutableCopy];
    
    // Tip: If we don't know the number of columns we can call the following method and use the NSUInteger object instead of the NUMBEROFCOLUMNS macro
//     NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
    
    // We calculate the item size of each column
    if (self.itemsSize.count != NUMBEROFCOLUMNS) {
        [self calculateItemsSize];
    }
    
    // We loop through all items
    for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
        NSMutableArray *sectionAttributes = [@[] mutableCopy];
        for (NSUInteger index = 0; index < NUMBEROFCOLUMNS; index++) {
            CGSize itemSize = [self.itemsSize[index] CGSizeValue];
            
            // We create the UICollectionViewLayoutAttributes object for each item and add it to our array.
            // We will use this later in layoutAttributesForItemAtIndexPath:
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
            
//            if (section == 0 && index == 0) {
            if (index == 0) {
                attributes.zIndex = 1024; // Set this value for the first item (Sec0Row0) in order to make it visible over first column and first row
            }
//            } else if (section == 0 || index == 0) {
//                attributes.zIndex = 1023; // Set this value for the first row or section in order to set visible over the rest of the items
//            }
//            if (section == 0) {
//                CGRect frame = attributes.frame;
//                frame.origin.y = self.collectionView.contentOffset.y;
//                attributes.frame = frame; // Stick to the top
//            }
            if (index == 0) {
                CGRect frame = attributes.frame;
                frame.origin.x = self.collectionView.contentOffset.x;
                attributes.frame = frame; // Stick to the left
            }
            
            [sectionAttributes addObject:attributes];
            
            xOffset = xOffset+itemSize.width;
            column++;
            
            // Create a new row if this was the last column
            if (column == NUMBEROFCOLUMNS) {
                if (xOffset > contentWidth) {
                    contentWidth = xOffset;
                }
                
                // Reset values
                column = 0;
                xOffset = 0;
                yOffset += itemSize.height;
            }
        }
        [self.itemAttributes addObject:sectionAttributes];
    }
    
    // Get the last item to calculate the total height of the content
    UICollectionViewLayoutAttributes *attributes = [[self.itemAttributes lastObject] lastObject];
    contentHeight = attributes.frame.origin.y+attributes.frame.size.height;
    self.contentSize = CGSizeMake(contentWidth, contentHeight);
}

- (void)calculateItemsSize
{
    for (NSUInteger index = 0; index < NUMBEROFCOLUMNS; index++) {
        if (self.itemsSize.count <= index) {
            CGSize itemSize = [self sizeForItemWithColumnIndex:index];
            NSValue *itemSizeValue = [NSValue valueWithCGSize:itemSize];
            [self.itemsSize addObject:itemSizeValue];
        }
    }
}

- (CGSize)sizeForItemWithColumnIndex:(NSUInteger)columnIndex {
    CGFloat height = 160;
    
    if (columnIndex == 0) {
        return CGSizeMake(0, height);
    } else {
        return CGSizeMake(150, height);
    }
}

@end
