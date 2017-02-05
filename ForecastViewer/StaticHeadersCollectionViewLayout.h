//
//  StaticHeadersCollectionViewLayout.h
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import <UIKit/UIKit.h>

@interface StaticHeadersCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, strong) NSMutableArray *itemAttributes;
@property (nonatomic, strong) NSMutableArray *itemsSize;
@property (nonatomic, assign) CGSize contentSize;

@end
