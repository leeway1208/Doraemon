//
//  BaseModel.m
//  Doraemon
//
//  Created by liwei wang on 6/7/2016.
//  Copyright © 2016 liwei wang. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel



MJCodingImplementation

//+(void)parseInterviewModelJson:(NSData *)jsonData{
//    
//    NSArray * tempData =  [[jsonData mutableObjectFromJSONData] objectForKey:@"data"];
//    InterviewModel *mInterview = [InterviewModel new];
//    mInterview.companyName = [NSString stringWithFormat:@"%@",[[tempData objectAtIndex:0]objectForKey:@"company"]];
//    mInterview.firstTopic = [NSString stringWithFormat:@"%@",[[tempData objectAtIndex:0]objectForKey:@"topic"]];
//    mInterview.secondTopic = [NSString stringWithFormat:@"%@",[[tempData objectAtIndex:1]objectForKey:@"topic"]];
//    mInterview.firstAllowTime = [NSString stringWithFormat:@"%@",[[tempData objectAtIndex:0]objectForKey:@"allow_time"]];
//    mInterview.secondAllowTime = [NSString stringWithFormat:@"%@",[[tempData objectAtIndex:1]objectForKey:@"allow_time"]];
//    
//    [mInterview saveInterviewModel:mInterview];
//    
//    
//}
//
//
//-(void)saveInterviewModel:(InterviewModel *)interviewAPI{
//    NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",]];
//    // 归档
//    [NSKeyedArchiver archiveRootObject:interviewAPI toFile:file];
//    
//}
//
//
//+(InterviewModel *)getInterviewModel{
//    NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:@"musers.data"];
//    InterviewModel *decodedBag = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
//    
//    return decodedBag;
//}

@end
