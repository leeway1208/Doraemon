//
//  HttpRequest.h
//  httea
//
//  Created by liwei wang on 1/9/15.
//  Copyright (c) 2015 httea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject
+(HttpRequest *)instance;


-(void)getRequest:(NSString *)requestStr  delegate:(id)delegate  RequestDictionary:(NSDictionary *)requestDictionary;

-(void)postRequest:(NSString *)requestStr  RequestDictionary:(NSDictionary *)requestDictionary delegate:(id)delegate;

- (void)getQueueRequest:(NSString *)requestStr delegate:(id)delegate RequestDictionary:(NSDictionary *)requestDictionary;

-(void)postQueueRequest:(NSString *)requestStr RequestDictionary:(NSDictionary *)requestDictionary delegate:(id)delegate;


-(void)postRecordRequest:(NSString *)requestStr RequestDictionary:(NSDictionary *)requestDictionary delegate:(id)delegate;

-(void)cancelMyRequest;
@end
