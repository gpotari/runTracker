//
//  DatabaseConnector.h
//  InterMap
//
//  Created by Pótári Gábor on 2014. 11. 12..
//  Copyright (c) 2014. Intermap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKMapView.h>


@interface DatabaseConnector : NSObject {
    int trackId;
}

+ (id)databaseConnector;
@property(nonatomic,retain) NSMutableArray *localMasterDataIds;
-(bool)connectToDatabase;

-(void)insertNewTrack;
-(void)insertNewTrackPoint:(CLLocation*)coord;
-(NSMutableArray*)getRoadsFromLocalDatabase;
-(int)getRoadCount;
-(int)getTrackPointCount;

-(void)saveTrack:(NSString*)name comment:(NSString*)comment description:
(NSString*)_description;

#pragma statisctics
-(double)getMinDistFromDB;
-(double)getMaxDistFromDB;
-(double)getTodayDistFromDB;
-(double)getThisWeekDistFromDB;

@end
