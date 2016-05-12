//
//  MapViewController.m
//  RunTracker
//
//  Created by Potari Gabor on 2016. 03. 28..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"
#include <MapKit/MapKit.h>
#import "DatabaseConnector.h"
#import "DataProvider.h"

@interface MapViewController () {
   NSTimer* timer;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    tracking = false;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    //Csak ios 8-as verzió felett
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.mapView.delegate = self;
    self.mapView.pitchEnabled = YES;
    self.mapView.showsUserLocation = YES;
    
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey: @"mapTypeIndex"]) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey: @"trackColorIndex"]) {
        case 0:
            _trackColor = [UIColor blueColor];
            break;
        case 1:
            _trackColor = [UIColor greenColor ];
            break;
        case 2:
            _trackColor = [UIColor redColor];
            break;
    }
    
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
    
    if(tracking) {
        UIStoryboard *mainStoryBoard = self.storyboard ;
        UIViewController* vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SaveTrackViewController"];
       
        [self.revealViewController setFrontViewController:vc animated:YES];
    }
    else
    {
        [_trackButton setBackgroundImage:[UIImage imageNamed:@"stopTrack"] forState:UIControlStateNormal];
        
        DatabaseConnector* databaseConnector = [DatabaseConnector databaseConnector];
        [databaseConnector insertNewTrack];
        
        tracking = YES;
    }
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    DataProvider* dataProvider = [DataProvider dataProvider];
    CLLocation* actLocation =[[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    
    
    if(tracking) {
        
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calculateTrackValues) userInfo:nil repeats:YES];
        
        CLLocation* c = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        
        [dataProvider addToTrackList:c];
        DatabaseConnector *databaseConnector = [DatabaseConnector databaseConnector];
        [databaseConnector insertNewTrackPoint:c];
        
        trackLayer = [[MKPolyline alloc] init];
        NSMutableArray* trackArray = [[NSMutableArray alloc] initWithArray:[dataProvider getTrackList]];
        CLLocationCoordinate2D coordinates[trackArray.count];
        for(int i=0; i<trackArray.count;++i){
            CLLocationCoordinate2D actCoord;
            actCoord.longitude = ((CLLocation*)trackArray[i]).coordinate.longitude;
            actCoord.latitude = ((CLLocation*)trackArray[i]).coordinate.latitude;
            coordinates[i] = actCoord;
        }
        
        [dataProvider setDistance:[dataProvider getDistance] + [[dataProvider getLastMeasuredLocation] distanceFromLocation:actLocation]];
        if([dataProvider getTime] > 0) {
            [dataProvider setAvgSpeed:([dataProvider getAvgSpeed]*[dataProvider getMeasuredSpeedCount]+([dataProvider getDistance]/1000) /
                                       ((float)[dataProvider getTime]/3600) ) / ([dataProvider getMeasuredSpeedCount]+1)];
        }
        [dataProvider setMeasuredSpeedCount];
        
        MKPolyline* polyline = [MKPolyline polylineWithCoordinates:coordinates count:trackArray.count];
        [self.mapView removeOverlay:polyline];
        [self.mapView addOverlay:polyline];
    }

    
    [dataProvider setLastMeasuredLocation:actLocation];
}

-(void)calculateTrackValues {
    DataProvider* dataProvider = [DataProvider dataProvider];
    [dataProvider setTime:[dataProvider getTime]+1];
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
   
    
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = _trackColor;
    
    polylineView.lineWidth = 4.0;
    
    return polylineView;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
