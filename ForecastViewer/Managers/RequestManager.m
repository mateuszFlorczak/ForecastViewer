//
//  RequestManager.m
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import "RequestManager.h"

@implementation RequestManager

+ (void)sendRequest:(NSURLRequest *)request successCallbackBlock:(SuccessBlock)successCallbackBlock {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse * _Nullable response,
                                               NSData * _Nullable data,
                                               NSError * _Nullable error) {
                               if (data.length > 0 && error == nil) {
                                   successCallbackBlock(data);
                               } else if (data.length == 0 && error == nil) {
                                   NSLog(@"didn't receive any data");
                               } else if (error != nil) {
                                   NSLog(@"error sending request: %@", error);
                               }
                           }];
}

@end
