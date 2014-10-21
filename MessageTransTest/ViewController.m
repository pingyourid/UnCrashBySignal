//
//  ViewController.m
//  MessageTransTest
//
//  Created by zhangbin on 14-10-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ViewController.h"
#import "AAA.h"
#import "BBB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AAA *a = [[AAA alloc] init];
    [a plus];
    BBB *b = [[BBB alloc] init];
    AAA *aa = (AAA *)b;
    [aa plus];
    NSArray *arr = [NSArray array];
    NSMutableArray *mulArr = (NSMutableArray *)arr;
    [mulArr addObject:@"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
