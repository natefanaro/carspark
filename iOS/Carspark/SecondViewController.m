//
//  SecondViewController.m
//  Carspark
//
//  Created by Nate on 1/12/14.
//  Copyright (c) 2014 Nate Fanaro. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize activity, lastStatus, tempLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    activity.hidesWhenStopped = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshTemp:(UIButton *)sender {
    [activity startAnimating];
    lastStatus.text = @"";
    tempLabel.text = @"";

    SparkCom *com = [[SparkCom alloc] init];
    com.delegate = self;
    [com getDataForRequest:@"temperature" requestType:@"GET" withOptions:nil withSelector:@selector(requestTempFinished:)];
}

-(void) requestTempFinished: (id) data {
    [self requestFinished:data];
    tempLabel.text = [NSString stringWithFormat:@"%@", [data valueForKey:@"result"]];
}


- (IBAction)buttonTest:(UIButton *)sender {
    NSDictionary *param = @{@"mode" : @"test"};
    [self getDataForRequest:@"opt" withOptions:param];
}

- (IBAction)buttonStatus:(UIButton *)sender{
    [activity startAnimating];
    lastStatus.text = @"";
    SparkCom *com = [[SparkCom alloc] init];
    com.delegate = self;
    [com getDataForRequest:@"" requestType:@"GET" withOptions:nil withSelector:@selector(requestFinished:)];
}

- (void) getDataForRequest: (NSString *)path
               withOptions:(NSDictionary *)param {

    [activity startAnimating];
    lastStatus.text = @"";

    SparkCom *com = [[SparkCom alloc] init];
    com.delegate = self;
    [com getDataForRequest:path requestType:@"POST" withOptions:param withSelector:@selector(requestFinished:)];
}

-(void) requestFinished: (id) data {
    lastStatus.text = [data description];
    [activity stopAnimating];
    NSLog(@"requestFinished: data: %@", data);
}

@end
