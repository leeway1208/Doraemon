//
//  htteaHttpDelegate.h
//  httea
//
//  Created by liwei wang on 1/9/15.
//  Copyright (c) 2015 httea. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DoraemonHttpDelegate<NSObject>
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
-(void)cancelMyRequest;
@end
