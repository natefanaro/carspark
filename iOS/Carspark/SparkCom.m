//
//  SparkCom.m
//  Carspark
//
//  Created by Nate on 1/12/14.
//  Copyright (c) 2014 Nate Fanaro. All rights reserved.
//

#import "SparkCom.h"

@implementation SparkCom

@synthesize lastResponse;

- (void)getDataForRequest:(NSString *)path
              requestType:(NSString *)type
              withOptions:(NSDictionary *)options
             withSelector:(SEL)selector {

    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([[prefs stringForKey:@"deviceId"] length] <= 0 || [[prefs stringForKey:@"accessToken"] length] <= 0) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Misconfigured"
                                                          message:@"Device ID and/or Access Token are missing. Please add in Settings."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [self.delegate performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];
        [message show];
        return;
    }

    NSLog(@"path %@", path);
    NSLog(@"type %@", type);

    if (![type isEqualToString:@"GET"] && ![type isEqualToString:@"POST"]) {
        NSLog(@"invalid requestType sent %@ (expecting GET or POST)", type);
        return;
    }

    NSString *url = [NSString stringWithFormat:@"https://api.spark.io/v1/devices/%@/%@", [prefs stringForKey:@"deviceId"], path];
    
    if (options == nil) {
        options = [[NSDictionary alloc] init];
    }

    NSMutableDictionary *params = [options mutableCopy];

    params[@"access_token"] = [prefs stringForKey:@"accessToken"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSLog(@"%@", url);
    NSLog(@"%@", [params description]);

    if ([type isEqualToString:@"POST"]) {
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObject: %@", responseObject);
            lastResponse = responseObject;
            if (selector) {
                [self.delegate performSelectorOnMainThread:selector withObject:responseObject waitUntilDone:NO];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            lastResponse = error;
            if (selector) {
                [self.delegate performSelectorOnMainThread:selector withObject:error waitUntilDone:NO];
            }
        }];
        return;
    }

    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject: %@", responseObject);
        lastResponse = responseObject;
        if (selector) {
            [self.delegate performSelectorOnMainThread:selector withObject:responseObject waitUntilDone:NO];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        lastResponse = error;
        if (selector) {
            [self.delegate performSelectorOnMainThread:selector withObject:error waitUntilDone:NO];
        }
    }];
}


@end
