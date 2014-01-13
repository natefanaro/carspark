//
//  SparkCom.h
//  Carspark
//
//  Created by Nate on 1/12/14.
//  Copyright (c) 2014 Nate Fanaro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SparkComDelegate;


@interface SparkCom : NSObject {
    id lastResponse;
}

- (void)getDataForRequest:(NSString *)url
              requestType:(NSString *)type
              withOptions:(NSDictionary *)options
             withSelector:(SEL)selector;

@property (strong, retain) NSObject <SparkComDelegate> *delegate;
@property (strong, retain) id lastResponse;

@end

@protocol SparkComDelegate <NSObject>

@end