//
//  SettingsViewController.h
//  RunTracker
//
//  Created by Potari Gabor on 2016. 04. 04..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "ViewController.h"

@interface SettingsViewController : UIViewController
- (IBAction)backButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
- (IBAction)saveButtonClicked:(id)sender;

@end
