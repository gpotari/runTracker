//
//  SaveTrackViewController.m
//  RunTracker
//
//  Created by Potari Gabor on 2016. 03. 28..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "SaveTrackViewController.h"
#import "SWRevealViewController.h"
#import "DatabaseConnector.h"

@interface SaveTrackViewController ()

@end

@implementation SaveTrackViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonClicked:(id)sender {
    
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];
}

- (IBAction)saveButtonClicked:(id)sender {
    
    
    DatabaseConnector* databaseConnector = [DatabaseConnector databaseConnector];
    [databaseConnector saveTrack:_nameTextField.text comment:_commentTextView.text description:_descriptionTextField.text ];

    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Felmérés mentése"
                                  message:@"Sikeres mentés"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    UIStoryboard *mainStoryBoard = self.storyboard ;
                                    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
                                    
                                    [self.revealViewController setFrontViewController:vc animated:YES];

                                    
                                    
                                }];

    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
 }
@end
