//
//  Tour.h
//  InterMap
//
//  Created by Pótári Gábor on 2014.10.18..
//  Copyright (c) 2014 Intermap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKMapView.h>

@interface Tour : NSObject {
    int Id;
    NSString* name;
    NSMutableArray* coordinates;
    NSNumber* low;
    NSNumber* high;
    int time;
    float length;
    NSNumber* difficulty;
    NSString* brand;
    int firstPicId;
    int coordCount;
    NSString* description;
    NSString* shortDesc;
    int color;
    NSString* type;
    NSString* pictureIds;
    NSMutableArray* picturePlaces;
    int syncable;
    int typeId;
    int startTime;
    NSArray* friendIds;
    int favourite;
}

-(NSArray*)getFriendIds;
-(void)setFriendIds:(NSArray*)_friends;

- (void)setId:(int)_id;
- (int)getId;

- (void)setLow:(NSNumber*)_low;
- (NSNumber*)getLow;

- (void)setHigh:(NSNumber*)_high;
- (NSNumber*)getHigh;

- (void)setLength:(float)_length;
- (float)getLength;

-(void)setTypeId:(int)_typeId;
-(int)getTypeId;

- (void)setName:(NSString*)_name;
- (NSString*)getName;

- (void)setCoordinates:(NSMutableArray*)_coordinates;
- (NSMutableArray*)getCoordinates;

- (void)setTime:(int)_id;
- (int)getTime;

- (void)setStartTime:(int)_id;
- (int)getStartTime;


- (void)setDifficulty:(NSNumber*)_dif;
- (NSNumber*)getDifficulty;

- (void)setBrand:(NSString*)_brand;
- (NSString*)getBrand;

-(void)setFirstPicId:(int)_picId;
-(int)getFirstPicId;

-(void)setCount:(int)c;
-(int)getCount;

-(void)setColor:(int)c;
-(int)getColor;

-(NSString*)getDescription;
-(void)setDescription:(NSString*)desc;

-(NSString*)getShortDesc;
-(void)setShortDesc:(NSString*)desc;

-(void)setType:(NSString*)_type;
-(NSString*)getType;

-(NSString*)getPictureIds;
-(void)setPictureIds:(NSString*)_picId;

-(void)setPicturePlaces:(NSMutableArray *)_picPlaces;
-(NSMutableArray*)getPicturePlaces;

-(void)setSyncable:(int)_syncable;
-(int)getSyncable;

-(int)getFavourite;
-(void)setFavourite:(int)_rate;
@end
