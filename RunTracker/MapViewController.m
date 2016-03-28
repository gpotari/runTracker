//
//  MapViewController.m
//  RunTracker
//
//  Created by Potari Gabor on 2016. 03. 28..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)backButtonClicked:(id)sender {
    
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainWindowViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];
    
}

- (IBAction)startTrackButtonClicked:(id)sender {
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SaveTrackViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];
}
@end
