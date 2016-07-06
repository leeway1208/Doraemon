//
//  HttpRequest.m
//  EyeBB
//
//  Created by Evan on 15/2/26.
//  Copyright (c) 2015年 EyeBB. All rights reserved.
//

#import "HttpRequest.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "BaseViewController.h"
#import "ASIDownloadCache.h"
#import "HttpRequestUtils.h"
#import "ASINetworkQueue.h"

@interface HttpRequest()

@property(strong,nonatomic) NSMutableDictionary *clientDelegates;
@property (strong,nonatomic) NSString *methodStr;
@property (nonatomic)  ASIHTTPRequest *cancelGetRequest;
@property (nonatomic) ASIFormDataRequest *cancelPostRequest;

//queue
@property(strong,nonatomic) ASINetworkQueue *queue;
@property(strong,nonatomic) NSMutableDictionary *requestGetQueueDic;
@property(strong,nonatomic) NSMutableDictionary *requestPostQueueDic;


@end
@implementation HttpRequest
static HttpRequest *instance;

//queue
static  NSMutableArray *requestGetQueueArray;
static NSMutableArray *requestGetQueueMethodStrAy;

static  NSMutableArray *requestPostQueueArray;
static NSMutableArray *requestPostQueueMethodStrAy;

@synthesize  clientDelegates;
#pragma mark ---
#pragma mark --- 处理业务逻辑委托
-(NSMutableDictionary *)clientDelegates{
    
    if(clientDelegates==nil){
        clientDelegates = [[NSMutableDictionary alloc] init];
        
    }
    
    return clientDelegates;
}
#pragma mark ---
#pragma mark ---单例实现
+(HttpRequest *)instance{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        if(instance==nil){
            instance = [[self alloc] init];
            
            requestGetQueueArray = [[NSMutableArray alloc]init];
            requestGetQueueMethodStrAy = [[NSMutableArray alloc]init];
            
            requestPostQueueArray  = [[NSMutableArray alloc]init];
            requestPostQueueMethodStrAy = [[NSMutableArray alloc]init];
        }
        
    });
    return instance;
    
}


-(void)getRequest:(NSString *)requestStr delegate:(id)delegate RequestDictionary:(NSDictionary *)requestDictionary
{
    [self cancelMyRequest];
    
    self.methodStr=requestStr;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:SERVER_URL"%@",requestStr]];
    
    if (requestDictionary!=nil)
    {
        //%@=%@&
        int tempNum=0;
        for (id key in requestDictionary)
        {
            NSString *str;
            if (tempNum==0) {
                str=[NSString stringWithFormat:@"?%@=%@",key,[requestDictionary objectForKey:key]];
            }
            else
            {
                str=[NSString stringWithFormat:@"&%@=%@",key,[requestDictionary objectForKey:key]];
            }
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,str]];
            tempNum++;
        }
    }
    [[self clientDelegates] setObject:delegate forKey:self.methodStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy ];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setTimeOutSeconds:10];
    [request setValidatesSecureCertificate:NO];
    [request setDelegate:self];
    
    //[request failWithError:ASIRequestTimedOutError];
    [request startAsynchronous];
    //[request setDidFailSelector:@selector(requestFailed:)];
}


-(void)postRequest:(NSString *)requestStr RequestDictionary:(NSDictionary *)requestDictionary delegate:(id)delegate
{
    [self cancelMyRequest];
    
    self.methodStr=requestStr;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:SERVER_URL"%@",requestStr]];
    [[self clientDelegates] setObject:delegate forKey:self.methodStr];
    
    NSLog(@"self.methodStr 1 = %@",self.methodStr);
    
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    
    [ request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy ];
    if ([requestDictionary count] > 0) {
        for (NSString *key in requestDictionary) {
            [request setPostValue:requestDictionary[key] forKey:key];
        }
    }
    
    [request setTimeOutSeconds:10];
    [request setDelegate:self];
    [request startAsynchronous];
    //[request setDidFailSelector:@selector(requestFailed:)];
    
}


-(void)postRecordRequest:(NSString *)requestStr RequestDictionary:(NSDictionary *)requestDictionary delegate:(id)delegate{
    [self cancelMyRequest];
    
    self.methodStr=requestStr;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:SERVER_URL"%@",requestStr]];
    [[self clientDelegates] setObject:delegate forKey:self.methodStr];
    
    NSLog(@"self.methodStr 1 = %@   URL(%@)",self.methodStr,url);
    
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    
    [ request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy ];
    if ([requestDictionary count] > 0) {
        for (NSString *key in requestDictionary) {
            if ([key isEqualToString:@"id_num"]) {
                [request setPostValue:requestDictionary[key] forKey:key];
                NSLog(@"ID (%@)",requestDictionary[key]);
                
            }else{
                NSLog(@"requestDictionary[key] --> %@",requestDictionary[key]);
                
                
                NSArray *array = [[NSString stringWithFormat:@"%@",requestDictionary[key]] componentsSeparatedByString:@"/"];
                NSLog(@"array -->  %@",array[11]);
                
                
                NSString *fileName = array[11];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *docDir = [paths objectAtIndex:0];
                
                //读取某个文件
                NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/Videos/%@",docDir,fileName]];
                
     
                
                
                [request setData:data withFileName:fileName andContentType:@"multipart/form-data" forKey:key];
                
                
                
            }
            
        }
    }
    
    [request setTimeOutSeconds:10];
    [request setDelegate:self];
    [request startAsynchronous];
}


- (void)requestFinished:(ASIHTTPRequest *)request //delegate:(id)delegate
{
    //    EyeBBViewController *httpView = (EyeBBViewController *)delegate;
    //     NSLog(@"---%@,---%@\n",[NSString stringWithFormat:@"%@",httpView.class],httpView.nibName);
    NSString *responseString = [request responseString];
    
    BaseViewController *clientDelegate = [[self clientDelegates] objectForKey: self.methodStr];
    
    [[self clientDelegates] removeObjectForKey:self.methodStr];
    [clientDelegate requestFinished:request tag:self.methodStr];
    
    
    // 当以文本形式读取返回内容时用这个方法
    
    
    
    //    // 当以二进制形式读取返回内容时用这个方法
    //
    //    NSData *responseData = [request responseData];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    NSString *responseString = [request responseString];
    BaseViewController  *clientDelegate = [[self clientDelegates] objectForKey: self.methodStr];
    
    [[self clientDelegates] removeObjectForKey:self.methodStr];
    [clientDelegate requestFailed:request tag:self.methodStr];
    //    NSString *message = NULL;
    //
    //    NSError *error = [request error];
    //    switch ([error code])
    //    {
    //        case ASIRequestTimedOutErrorType:
    //            message = @"AASDSADSADAS";
    //            break;
    //        case ASIConnectionFailureErrorType:
    //            message = @"AASDSADSADAddd ddS";
    //            break;
    //
    //    }
    //
    //    NSLog(@"------> %@",message);
    //
}

-(void)cancelMyRequest{
    
    for (ASIHTTPRequest *request in ASIHTTPRequest.sharedQueue.operations)
    {
        if(![request isCancelled])
        {
            [request cancel];
            [request setDelegate:nil];
        }
    }
}

#pragma mark - get queue request

- (void)getQueueRequest:(NSString *)requestStr delegate:(id)delegate RequestDictionary:(NSDictionary *)requestDictionary
{
    if(!self.queue)
        self.queue = [[ASINetworkQueue alloc] init];
    
    _requestGetQueueDic =  [[NSMutableDictionary alloc]initWithCapacity:4];
    
    self.methodStr=requestStr;
    //主程序的相对应判断
    [requestGetQueueMethodStrAy addObject:self.methodStr];
    
    
    //初始化
    [_requestGetQueueDic setObject:[NSString stringWithFormat:SERVER_URL"%@",requestStr] forKey:@"url"  ];
    [_requestGetQueueDic setObject:delegate forKey:@"delegate"  ];
    [_requestGetQueueDic setObject:requestDictionary forKey:@"requestDictionary"  ];
    [_requestGetQueueDic setObject:self.methodStr forKey:@"methodStr"  ];
    [requestGetQueueArray addObject:_requestGetQueueDic];
    
    
    
    //循环队列
    for (int i = 0; i < requestGetQueueArray.count; i ++) {
        NSURL *url = [NSURL URLWithString:[[requestGetQueueArray objectAtIndex:i]objectForKey:@"url" ]];
        
        if ([[requestGetQueueArray objectAtIndex:i]objectForKey:@"requestDictionary" ]!=nil)
        {
            //%@=%@&
            int tempNum=0;
            for (id key in [[requestGetQueueArray objectAtIndex:i]objectForKey:@"requestDictionary" ])
            {
                NSString *str;
                if (tempNum==0) {
                    str=[NSString stringWithFormat:@"?%@=%@",key,[[[requestGetQueueArray objectAtIndex:i]objectForKey:@"requestDictionary" ] objectForKey:key]];
                }
                else
                {
                    str=[NSString stringWithFormat:@"&%@=%@",key,[[[requestGetQueueArray objectAtIndex:i]objectForKey:@"requestDictionary" ] objectForKey:key]];
                }
                url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,str]];
                tempNum++;
            }
        }
        [[self clientDelegates] setObject:[[requestGetQueueArray objectAtIndex:i]objectForKey:@"delegate" ] forKey:[[requestGetQueueArray objectAtIndex:i]objectForKey:@"methodStr" ]];
        
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        
        [request setDidFinishSelector:@selector(requestGetDone:)];
        [request setDidFailSelector:@selector(requestGetWentWrong:)];
        [self.queue addOperation:request];
        
        [requestGetQueueArray removeObjectAtIndex:i];
    }
    
    
    
    [self.queue go];
    
    
    NSLog(@"requestQueueArray  -->  %@",requestGetQueueArray);
    
}


- (void)requestGetDone:(ASIHTTPRequest*)req
{
    
    NSString *responseString = [req responseString];
    //   NSLog(@"Request returned responseString: %@",responseString);
    
    for (int i = 0 ;  i < requestGetQueueMethodStrAy.count; i ++) {
        BaseViewController *clientDelegate = [[self clientDelegates] objectForKey: [requestGetQueueMethodStrAy objectAtIndex:i]];
        
        [[self clientDelegates] removeObjectForKey:[requestGetQueueMethodStrAy objectAtIndex:i]];
        [clientDelegate requestFinished:req tag:[requestGetQueueMethodStrAy objectAtIndex:i]];
        
        
        [requestGetQueueMethodStrAy removeObjectAtIndex:i];
    }
    
}

- (void)requestGetWentWrong:(ASIHTTPRequest*)req
{
    NSLog(@"Request returned an error: %@",[req error]);
    
    for (int i = 0 ;  i < requestGetQueueMethodStrAy.count; i ++) {
        BaseViewController *clientDelegate = [[self clientDelegates] objectForKey: [requestGetQueueMethodStrAy objectAtIndex:i]];
        
        [[self clientDelegates] removeObjectForKey:[requestGetQueueMethodStrAy objectAtIndex:i]];
        [clientDelegate requestFailed:req tag:[requestGetQueueMethodStrAy objectAtIndex:i]];
        
        
        [requestGetQueueMethodStrAy removeObjectAtIndex:i];
    }
    
}


#pragma mark - post queue request

-(void)postQueueRequest:(NSString *)requestStr RequestDictionary:(NSDictionary *)requestDictionary delegate:(id)delegate
{
    
    
    if(!self.queue)
        self.queue = [[ASINetworkQueue alloc] init];
    
    _requestPostQueueDic =  [[NSMutableDictionary alloc]initWithCapacity:4];
    
    self.methodStr=requestStr;
    [requestPostQueueMethodStrAy addObject:self.methodStr];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:SERVER_URL"%@",requestStr]];
    
    
    
    [_requestPostQueueDic setObject:url forKey:@"url"  ];
    [_requestPostQueueDic setObject:delegate forKey:@"delegate"  ];
    [_requestPostQueueDic setObject:requestDictionary forKey:@"requestDictionary"  ];
    [_requestPostQueueDic setObject:self.methodStr forKey:@"methodStr"  ];
    [requestPostQueueArray addObject:_requestPostQueueDic];
    
    
    
    
    for (int i = 0; i < requestPostQueueArray.count; i ++) {
        
        
        [[self clientDelegates] setObject:[[requestPostQueueArray objectAtIndex:i]objectForKey:@"delegate" ] forKey:[[requestPostQueueArray objectAtIndex:i]objectForKey:@"methodStr" ]];
        
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[[requestPostQueueArray objectAtIndex:i ]objectForKey:@"url" ]];
        
        if ([[requestPostQueueArray objectAtIndex:i ]objectForKey:@"requestDictionary" ] > 0) {
            for (NSString *key in [[requestPostQueueArray objectAtIndex:i ]objectForKey:@"requestDictionary" ]) {
                [request setPostValue:[[requestPostQueueArray objectAtIndex:i ]objectForKey:@"requestDictionary" ][key] forKey:key];
            }
        }
        
        [request setDelegate:self];
        
        [request setDidFinishSelector:@selector(requestPostDone:)];
        [request setDidFailSelector:@selector(requestPostWentWrong:)];
        [self.queue addOperation:request];
        
        [requestPostQueueArray removeObjectAtIndex:i];
    }
    
    
    
    [self.queue go];
    
    
    NSLog(@"requestPostQueueArray  -->  %@",requestPostQueueArray);
    
}

- (void)requestPostDone:(ASIHTTPRequest*)req
{
    
    NSString *responseString = [req responseString];
    //   NSLog(@"Request returned responseString: %@",responseString);
    
    for (int i = 0 ;  i < requestPostQueueMethodStrAy.count; i ++) {
        BaseViewController *clientDelegate = [[self clientDelegates] objectForKey: [requestPostQueueMethodStrAy objectAtIndex:i]];
        
        [[self clientDelegates] removeObjectForKey:[requestPostQueueMethodStrAy objectAtIndex:i]];
        [clientDelegate requestFinished:req tag:[requestPostQueueMethodStrAy objectAtIndex:i]];
        
        
        [requestPostQueueMethodStrAy removeObjectAtIndex:i];
    }
    
}

- (void)requestPostWentWrong:(ASIHTTPRequest*)req
{
    NSLog(@"Request returned an error: %@",[req error]);
    
    for (int i = 0 ;  i < requestPostQueueMethodStrAy.count; i ++) {
        BaseViewController *clientDelegate = [[self clientDelegates] objectForKey: [requestPostQueueMethodStrAy objectAtIndex:i]];
        
        [[self clientDelegates] removeObjectForKey:[requestPostQueueMethodStrAy objectAtIndex:i]];
        [clientDelegate requestFailed:req tag:[requestPostQueueMethodStrAy objectAtIndex:i]];
        
        
        [requestPostQueueMethodStrAy removeObjectAtIndex:i];
    }
    
}




@end

