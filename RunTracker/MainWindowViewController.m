//
//  MainWindowViewController.m
//  RunTracker
//
//  Created by Potari Gabor on 2016. 03. 10..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "MainWindowViewController.h"
#import "SWRevealViewController.h"

@interface MainWindowViewController ()

@end

@implementation MainWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    // Do any additional setup after loading the view.
}

- (void)customSetup{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        [_menuButton  addTarget:revealViewController
                         action:@selector(revealToggle:)
               forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)mapClicked:(id)sender {
    
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
  
    [self.revealViewController setFrontViewController:vc animated:YES];
    
    
}

- (IBAction)statisticButtonClicked:(id)sender {
    
    
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"StatisticViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];

}

- (IBAction)settingButtonClicked:(id)sender {
    
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];
}
@end
