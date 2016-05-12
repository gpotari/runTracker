//
//  StatisticViewController.m
//  RunTracker
//
//  Created by Potari Gabor on 2016. 04. 04..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "StatisticViewController.h"
#import "SWRevealViewController.h"
#import "DatabaseConnector.h"

@interface StatisticViewController ()

@end

@implementation StatisticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    
    DatabaseConnector* databaseConnector = [DatabaseConnector databaseConnector];
    
    float max = [databaseConnector getMaxDistFromDB]/1000;
    float min = [databaseConnector getMinDistFromDB] / 1000;
    float today =[databaseConnector getTodayDistFromDB] / 1000;
    float week = [databaseConnector getThisWeekDistFromDB] / 1000;
    NSString * unit = @" km";
    if([[NSUserDefaults standardUserDefaults] integerForKey: @"measureTypeIndex"] == 1) {
        max *= 0.621371192;
        min *= 0.621371192;
        today*= 0.621371192;
        week *= 0.621371192;
        unit = @" miles";
    }
        
    _maxDist.text = [[NSString stringWithFormat:@"%f ", max ] stringByAppendingString:unit];
    _minDist.text = [[NSString stringWithFormat:@"%f ", min ] stringByAppendingString:unit];
    _todayDistance.text = [[NSString stringWithFormat:@"%f ", today ] stringByAppendingString:unit];
    _thisWeekDistance.text = [[NSString stringWithFormat:@"%f ", week ] stringByAppendingString:unit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (void)customSetup{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }
}



- (IBAction)backButtonPressed:(id)sender {
    
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainWindowViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];
    
}
@end
