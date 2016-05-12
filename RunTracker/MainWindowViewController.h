//
//  MainWindowViewController.h
//  RunTracker
//
//  Created by Potari Gabor on 2016. 03. 10..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainWindowViewController : UIViewController
- (IBAction)mapClicked:(id)sender;
- (IBAction)statisticButtonClicked:(id)sender;
- (IBAction)settingButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end
