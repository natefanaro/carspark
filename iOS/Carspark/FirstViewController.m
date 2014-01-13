//
//  FirstViewController.m
//  Carspark
//
//  Created by Nate on 1/12/14.
//  Copyright (c) 2014 Nate Fanaro. All rights reserved.
//

#import "FirstViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize activity;

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

- (IBAction)aux:(UISegmentedControl *)sender {

    NSLog(@"segmentedControl: %@", sender);
    NSLog(@"segmentedControl: %li", (long)[sender selectedSegmentIndex]);

    int mode = (int)sender.selectedSegmentIndex;
    mode++;

    NSDictionary *param = @{@"mode" : [NSString stringWithFormat:@"%i", mode]};

    [self getDataForRequest:@"aux" withOptions:param];
}

- (IBAction)buttonStart:(UIButton *)sender {
    [self getDataForRequest:@"start" withOptions:nil];
}

- (IBAction)carCheck:(UIButton *)sender {
    NSDictionary *param = @{@"mode" : @"carcheck"};
    [self getDataForRequest:@"opt" withOptions:param];
}

- (IBAction)doorLock:(UISegmentedControl *)sender {
    NSLog(@"segmentedControl: %@", sender);
    NSLog(@"segmentedControl: %li", (long)[sender selectedSegmentIndex]);
    NSDictionary *param = @{@"mode" : [NSString stringWithFormat:@"%li", sender.selectedSegmentIndex]};
    [self getDataForRequest:@"door_lock" withOptions:param];
}

- (IBAction)valet:(UIButton *)sender {
    NSDictionary *param = @{@"mode" : @"valet"};
    [self getDataForRequest:@"opt" withOptions:param];
}

- (void) getDataForRequest: (NSString *)path
               withOptions:(NSDictionary *)param {

    [activity startAnimating];

    SparkCom *com = [[SparkCom alloc] init];
    com.delegate = self;
    [com getDataForRequest:path requestType:@"POST" withOptions:param withSelector:@selector(requestFinished:)];
}

-(void) requestFinished: (id) data {
    [activity stopAnimating];
    NSLog(@"requestFinished: data: %@", data);
}

@end
