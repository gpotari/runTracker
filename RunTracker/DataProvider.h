//
//  DataProvider.h
//  InterMap
//
//  Created by Pótári Gábor on 2014.10.16..
//  Copyright (c) 2014 Intermap. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Tour.h"

@interface DataProvider : NSObject {

    NSMutableArray* poiList;
    NSMutableArray* tourList;
    
    //trackelés
    NSMutableArray* trackList;
    bool isTracking;
    int time;
    float distance;
    CLLocation* lastMeasuredLocation;
    float avgSpeed;
    int measuredSpeedCount;
    NSString* domain;
    bool firstStart;
    NSMutableArray* speedList;
    NSString* mapPoiFilter;
    NSString* mapTourFilter;
}

@property (nonatomic,retain) NSMutableArray* poiList;

+ (id)dataProvider;
- (void)setPoiList:(NSMutableArray*)_poiList;
- (NSMutableArray*)getPoiList;


- (NSMutableArray*)getTourList;
- (void)setTourList:(NSMutableArray*)_tourList;
-(void)addTour:(Tour*)t;

- (NSMutableArray*)getTrackList;
- (void)setTrackList:(NSMutableArray*)_trackList;
-(void)addToTrackList:(CLLocation*)_coord;

-(void)setIsTracking:(bool)_isTracking;
-(bool)getIsTracking;

-(NSString*)getDomain;

-(void)setDistance:(double)_dist;
-(float)getDistance;

-(void)setTime:(int)_time;
-(int)getTime;

-(CLLocation*)getLastMeasuredLocation;
-(void)setLastMeasuredLocation:(CLLocation*)_loc;

-(float)getAvgSpeed;
-(void)setAvgSpeed:(float)_avg;

-(int)getMeasuredSpeedCount;
-(void)setMeasuredSpeedCount;

-(void)restoreTrack;

-(bool)getFirstStart;
-(void)setFirstStart:(bool)_firstStart;

- (NSMutableArray*)getSpeedList;
- (void)addSpeedList:(float)_actSpeed;

-(void)setMapPoiFilter:(NSString*)_poiFilter;
-(NSString*)getMapPoiFilter;

@end
