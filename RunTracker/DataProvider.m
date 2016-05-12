//
//  DataProvider.m
//  InterMap
//
//  Created by Pótári Gábor on 2014.10.16..
//  Copyright (c) 2014 Intermap. All rights reserved.
//

#import "DataProvider.h"


@implementation DataProvider
@synthesize poiList;

+ (id)dataProvider{
    static DataProvider* dataProvider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        dataProvider = [[self alloc] init];
    });
    return dataProvider;
}

- (id)init {
    if(self == [super init]) {
        //teszt = [[NSString alloc] initWithString:@"Hello singleton"];
        poiList = [[NSMutableArray alloc] init];
        trackList = [[NSMutableArray alloc] init];
        speedList = [[NSMutableArray alloc] init];
        time = 0;
        distance = 0.0;
        avgSpeed = 0.0;
        isTracking = false;
        firstStart = true;
        mapPoiFilter = @"";
        
    }
    return self;
}

- (void)dealloc {

}

- (void)setPoiList:(NSMutableArray*)_poiList{
    
    if(poiList.count > 0) {
            [poiList removeAllObjects];
    }
    poiList = [[NSMutableArray alloc] init];
    poiList = _poiList;
}

- (NSMutableArray*)getPoiList{
    //NSLog(@"%lu",(unsigned long)poiList.count);

    return poiList;
}

- (NSMutableArray*)getTourList {
    return tourList;
}

-(void)addTour:(Tour*)t{
    bool found = NO;
    for(int i=0;i<tourList.count && !found;++i) {
        
        if([(Tour*)tourList[i] getId] == [t getId]) {
            found = YES;
            [(Tour*)tourList[i] setFriendIds:[t getFriendIds]];
        }
    }
    
    if(!found)
        [tourList addObject:t];
}



- (void)setTourList:(NSMutableArray*)_tourList {
    
    if(tourList.count > 0) {
        [tourList removeAllObjects];
    }
    tourList = [[NSMutableArray alloc] initWithArray:_tourList];
    
}

- (NSMutableArray*)getTrackList{
    return trackList;
}

- (void)setTrackList:(NSMutableArray*)_trackList{
    trackList = _trackList;
}

-(void)addToTrackList:(CLLocation*)_coord{
    [trackList addObject:_coord];
}

-(void)setIsTracking:(bool)_isTracking{
    isTracking = _isTracking;
}
-(bool)getIsTracking {
    return isTracking;
}


-(NSString*)getDomain{
    return domain;
}

-(void)setDistance:(double)_dist{
    distance = _dist;
}
-(float)getDistance{
    return distance;
}

-(void)setTime:(int)_time{
    time = _time;
}

-(int)getTime{
    return time;
}

-(CLLocation*)getLastMeasuredLocation {
    return lastMeasuredLocation;
}
-(void)setLastMeasuredLocation:(CLLocation*)_loc {
    lastMeasuredLocation = _loc;
}

-(float)getAvgSpeed {
    return avgSpeed;
}
-(void)setAvgSpeed:(float)_avg {
    avgSpeed = _avg;
}

-(int)getMeasuredSpeedCount {
    return measuredSpeedCount;
}
-(void)setMeasuredSpeedCount {
    measuredSpeedCount++;
}

-(void)restoreTrack{
    lastMeasuredLocation = nil;
    avgSpeed = 0.0;
    time = 0;
    measuredSpeedCount = 0;
    distance = 0;
}


-(bool)getFirstStart{
    return firstStart;
}

-(void)setFirstStart:(bool)_firstStart{
    firstStart = _firstStart;
}


- (NSMutableArray*)getSpeedList {
    return speedList;
}

- (void)addSpeedList:(float)_actSpeed {
    [speedList addObject:[NSNumber numberWithFloat:_actSpeed]];
}

-(void)setMapPoiFilter:(NSString*)_poiFilter {
    mapPoiFilter = _poiFilter;
}

-(NSString*)getMapPoiFilter {
    return mapPoiFilter;
}

@end



