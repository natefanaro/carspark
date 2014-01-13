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

static NSString *deviceId = @"deviceId";
static NSString *accessToken = @"accessToken";

- (void)getDataForRequest:(NSString *)path
              requestType:(NSString *)type
              withOptions:(NSDictionary *)options
             withSelector:(SEL)selector {
    
    NSLog(@"path %@", path);
    NSLog(@"type %@", type);

    if (![type isEqualToString:@"GET"] && ![type isEqualToString:@"POST"]) {
        NSLog(@"invalid requestType sent %@ (expecting GET or POST)", type);
        return;
    }

    NSString *url = [NSString stringWithFormat:@"https://api.spark.io/v1/devices/%@/%@", deviceId, path];
    
    if (options == nil) {
        options = [[NSDictionary alloc] init];
    }

    NSMutableDictionary *params = [options mutableCopy];

    params[@"access_token"] = accessToken;

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
