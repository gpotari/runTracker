//
//  ViewController.m
//  RunTracker
//
//  Created by Potari Gabor on 2016. 03. 04..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "DatabaseConnector.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(goForward) userInfo:nil repeats:NO];
    
    DatabaseConnector *db = [DatabaseConnector databaseConnector];
    [db connectToDatabase];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

-(void)goForward {
    UIStoryboard *mainStoryBoard = self.storyboard;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
}


- (IBAction)forwardButtonClicked:(id)sender {
    UIStoryboard *mainStoryBoard = self.storyboard;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
