//
//  RequestManager.h
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(NSData *responseData);

@interface RequestManager : NSObject

+ (void)sendRequest:(NSURLRequest *)request successCallbackBlock:(SuccessBlock)successCallbackBlock;

@end
