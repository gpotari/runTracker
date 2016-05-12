//
//  StatisticViewController.h
//  RunTracker
//
//  Created by Potari Gabor on 2016. 04. 04..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "ViewController.h"

@interface StatisticViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *minSpeed;
@property (weak, nonatomic) IBOutlet UILabel *maxSpeed;
- (IBAction)backButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *maxDist;
@property (weak, nonatomic) IBOutlet UILabel *minDist;

@property (weak, nonatomic) IBOutlet UILabel *todayDistance;
@property (weak, nonatomic) IBOutlet UILabel *thisWeekDistance;
@end
