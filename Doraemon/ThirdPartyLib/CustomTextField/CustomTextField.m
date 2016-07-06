//
//  CustomTextField.m
//  httea
//
//  Created by liwei wang on 10/9/15.
//  Copyright (c) 2015 httea. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width - 40, bounds.size.height);
    return inset;
}



-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width - 40, bounds.size.height);
    return inset;
}



@end
