//
//  FirstViewController.h
//  Carspark
//
//  Created by Nate on 1/12/14.
//  Copyright (c) 2014 Nate Fanaro. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController <SparkComDelegate> {
    IBOutlet UIActivityIndicatorView  *activity;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)aux:(UISegmentedControl *)sender;
- (IBAction)buttonStart:(UIButton *)sender;
- (IBAction)carCheck:(UIButton *)sender;
- (IBAction)doorLock:(UISegmentedControl *)sender;
- (IBAction)valet:(UIButton *)sender;

@end
