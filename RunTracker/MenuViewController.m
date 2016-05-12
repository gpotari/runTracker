//
//  MenuViewController.m
//  RunTracker
//
//  Created by Potari Gabor on 2016. 03. 10..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)settingsButtonClicked:(id)sender {
    
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];
    
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
}

- (IBAction)statisticButtonClicked:(id)sender {
    
    
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"StatisticViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];
    
    
}

- (IBAction)MapButtonClicked:(id)sender {
    
    
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];
    
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
}
@end
