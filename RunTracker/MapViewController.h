//
//  MapViewController.h
//  RunTracker
//
//  Created by Potari Gabor on 2016. 03. 28..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate> {
    bool tracking;
    MKPolyline* trackLayer;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
- (IBAction)backButtonClicked:(id)sender;

- (IBAction)startTrackButtonClicked:(id)sender;

@property(nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *trackButton;
@property ( weak, nonatomic) UIColor* trackColor;

@end
