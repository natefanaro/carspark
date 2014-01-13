//
//  SecondViewController.h
//  Carspark
//
//  Created by Nate on 1/12/14.
//  Copyright (c) 2014 Nate Fanaro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <SparkComDelegate>
{
    IBOutlet UIActivityIndicatorView  *activity;
    IBOutlet UITextView *lastStatus;
    IBOutlet UILabel *tempLabel;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;
@property (nonatomic, retain) IBOutlet UITextView *lastStatus;
@property (nonatomic, retain) IBOutlet UILabel *tempLabel;

- (IBAction)refreshTemp:(UIButton *)sender;
- (IBAction)buttonTest:(UIButton *)sender;
- (IBAction)buttonStatus:(UIButton *)sender;


@end
