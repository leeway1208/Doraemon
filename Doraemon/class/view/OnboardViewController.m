//
//  OnboardViewController.m
//  Doraemon
//
//  Created by liwei wang on 6/7/2016.
//  Copyright © 2016 liwei wang. All rights reserved.
//

#import "OnboardViewController.h"

@interface OnboardViewController ()

@end

@implementation OnboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadParameter];
    [self loadWidget];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //can cancel swipe gesture
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [self.view removeFromSuperview];
    
    [self setView:nil];
    [super viewDidDisappear:animated];
    
}




- (void)loadParameter{
    
    
}

- (void)loadWidget{
    
}

@end
