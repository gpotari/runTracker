//
//  MapViewController.h
//  RunTracker
//
//  Created by Potari Gabor on 2016. 03. 28..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
- (IBAction)backButtonClicked:(id)sender;

- (IBAction)startTrackButtonClicked:(id)sender;


@end
