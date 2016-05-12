//
//  SettingsViewController.m
//  RunTracker
//
//  Created by Potari Gabor on 2016. 04. 04..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *measureTextField;
@property (weak, nonatomic) IBOutlet UITextField *trackColorTextField;
@property (weak, nonatomic) IBOutlet UITextField *mapTypeTextField;
@property (weak, nonatomic) IBOutlet UISwitch *is3DSwitch;

@property ( strong , nonatomic) UIPickerView* typePicker;
@property ( strong , nonatomic) UITextField* currentTextField;
@property ( strong , nonatomic) NSArray *measureTypes;
@property ( strong , nonatomic) NSArray *colorTypes;
@property ( strong , nonatomic) NSArray *mapTypes;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    _measureTextField.delegate = (id)self;
    _trackColorTextField.delegate = (id)self;
    [_mapTypeTextField setDelegate: (id)self];
    
    
    _measureTypes = [[NSArray alloc] initWithObjects:@"Kilométer",@"Mérföld",nil];
    _colorTypes = [[NSArray alloc] initWithObjects:@"Kék",@"Zöld", @"Piros",nil];
    _mapTypes = [[NSArray alloc] initWithObjects:@"Alap",@"Műhold", @"Hibrid",nil];
    
    _typePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 403, self.view.bounds.size.width, 100 )];
    
    [_typePicker setDelegate: (id)self];
    _typePicker.showsSelectionIndicator = YES;
    
    
    _measureTextField.text = _measureTypes[[[NSUserDefaults standardUserDefaults] integerForKey: @"measureTypeIndex"]];
    _trackColorTextField.text =  _colorTypes[[[NSUserDefaults standardUserDefaults] integerForKey: @"trackColorIndex"]];
    _mapTypeTextField.text = _mapTypes[[[NSUserDefaults standardUserDefaults] integerForKey: @"mapTypeIndex"]];
    
    _measureTextField.inputView = _typePicker;
    _trackColorTextField.inputView = _typePicker;
    _mapTypeTextField.inputView = _typePicker;

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


#pragma Type

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _currentTextField = textField;
    return YES;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(_currentTextField == _measureTextField)
        return [_measureTypes count];
    else if(_currentTextField == _trackColorTextField)
        return [_colorTypes count];
    else
        return [_mapTypes count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(_currentTextField == _measureTextField)
        return [_measureTypes objectAtIndex: row];
    else if(_currentTextField == _trackColorTextField)
        return [_colorTypes objectAtIndex: row];
    else
        return [_mapTypes objectAtIndex:row];
    
}


- (IBAction)backButtonClicked:(id)sender {
    UIStoryboard *mainStoryBoard = self.storyboard ;
    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainWindowViewController"];
    
    [self.revealViewController setFrontViewController:vc animated:YES];
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(_currentTextField == _measureTextField)
         _measureTextField.text = _measureTypes[row];
    else if(_currentTextField == _trackColorTextField)
        _trackColorTextField.text = _colorTypes[row];
    else
        _mapTypeTextField.text = _mapTypes[row];
        
    [_currentTextField resignFirstResponder];
}

- (IBAction)saveButtonClicked:(id)sender {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Beállítások mentése"
                                  message:@"Sikeres mentés"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    [[NSUserDefaults standardUserDefaults] setInteger:[_measureTypes indexOfObject: _measureTextField.text] forKey:@"measureTypeIndex"];
                                    
                                    [[NSUserDefaults standardUserDefaults] setInteger:[_mapTypes indexOfObject:_mapTypeTextField.text] forKey:@"mapTypeIndex"];
                                    
                                    [[NSUserDefaults standardUserDefaults] setInteger:[_colorTypes indexOfObject:_trackColorTextField.text] forKey:@"trackColorIndex"];
                                    
                                    [[NSUserDefaults standardUserDefaults] synchronize];

                                    
                                    UIStoryboard *mainStoryBoard = self.storyboard ;
                                    UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainWindowViewController"];
                                    
                                    [self.revealViewController setFrontViewController:vc animated:YES];
                                    
                                    
                                    
                                }];
    
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];

}
@end
