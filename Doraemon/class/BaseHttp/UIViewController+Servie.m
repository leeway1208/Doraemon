//
//  UIViewController+htteaServie.m
//  httea
//
//  Created by liwei wang on 1/9/15.
//  Copyright (c) 2015 httea. All rights reserved.
//

#import "UIViewController+Servie.h"

@implementation UIViewController(Servie)
#pragma mark --
#pragma mark --- 获得网络控制器
-(HttpRequest *)HttpRequest{
    return [HttpRequest instance];
}

-(void)getRequest:(NSString *)requestStr  delegate:(id)delegate RequestDictionary:(NSDictionary *)requestDictionary
{
    [[self HttpRequest] getRequest:requestStr delegate:self RequestDictionary:requestDictionary];
}


-(void)postRequest:(NSString *)requestStr  RequestDictionary:(NSDictionary *)requestDictionary delegate:(id)delegate
{
    [[self HttpRequest] postRequest:requestStr RequestDictionary:requestDictionary delegate:self];
}

- (void)getQueueRequest:(NSString *)requestStr delegate:(id)delegate RequestDictionary:(NSDictionary *)requestDictionary{
    [[self HttpRequest] getQueueRequest:requestStr delegate:self RequestDictionary:requestDictionary];
}

-(void)postQueueRequest:(NSString *)requestStr RequestDictionary:(NSDictionary *)requestDictionary delegate:(id)delegate{
    [[self HttpRequest] postQueueRequest:requestStr RequestDictionary:requestDictionary delegate:self];
}

-(void)postRecordRequest:(NSString *)requestStr RequestDictionary:(NSDictionary *)requestDictionary delegate:(id)delegate{
        [[self HttpRequest] postRecordRequest:requestStr RequestDictionary:requestDictionary delegate:self];
}

-(void)cancelMyRequest{
    [[self HttpRequest] cancelMyRequest];
}

@end
