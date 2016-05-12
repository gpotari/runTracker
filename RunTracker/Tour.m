//
//  Tour.m
//  InterMap
//
//  Created by Pótári Gábor on 2014.10.18..
//  Copyright (c) 2014 Intermap. All rights reserved.
//

#import "Tour.h"

@implementation Tour

-(void)setCount:(int)c{
    coordCount = c;
}

-(int)getCount{
    return coordCount;
}

- (void)setId:(int)_id {
    Id = _id;
}
- (int)getId {
    return Id;
}

- (void)setLow:(NSNumber*)_low{
    low = _low;
}

- (NSNumber*)getLow {
    return low;
}

- (void)setHigh:(NSNumber*)_high {
    high = _high;
}

- (NSNumber*)getHigh {
    return high;
}

- (void)setLength:(float)_length {
    length = _length;
}

- (float)getLength {
    return length;
}

- (void)setName:(NSString*)_name {
    name = _name;
}

- (NSString*)getName {
    return name ;
}

- (void)setCoordinates:(NSMutableArray*)_coordinates {
    coordinates = [[NSMutableArray alloc] initWithArray:_coordinates];
}

- (NSMutableArray*)getCoordinates {
    return coordinates;
}

- (void)setTime:(int)_time {
    time = _time;
}

- (int)getTime {
    return time;
}

- (void)setDifficulty:(NSNumber*)_dif {
    difficulty = _dif;
}

- (NSNumber*)getDifficulty {
    return difficulty;
}

- (void)setBrand:(NSString*)_brand {
    brand = _brand;
}

- (NSString*)getBrand {
    return brand;
}


-(void)setFirstPicId:(int)_picId{
    firstPicId = _picId;
}

-(int)getFirstPicId{
    return firstPicId;
}
-(void)setColor:(int)c{
    color = c;
}
-(int)getColor{
    return color;
}

-(void)setDescription:(NSString*)desc{
    description = desc;
}
-(NSString*)getDescription{
    return description;
}

-(void)setShortDesc:(NSString*)desc{
    shortDesc = desc;
}
-(NSString*)getShortDesc{
    return shortDesc;
}

-(void)setTypeId:(int)_typeId{
    typeId = _typeId;
}

-(int)getTypeId{
    return typeId;
}

-(void)setType:(NSString*)_type{
    type = _type;
}
-(NSString*)getType{
    return type;
}
-(NSString*)getPictureIds{
    return pictureIds;
}
-(void)setPictureIds:(NSString*)_picId{
    pictureIds = _picId;
}


-(void)setPicturePlaces:(NSMutableArray *)_picPlaces{
    picturePlaces = [[NSMutableArray alloc] initWithArray:_picPlaces];
}
-(NSMutableArray*)getPicturePlaces{
    return picturePlaces;
}

-(void)setSyncable:(int)_syncable{
    syncable = _syncable;
}

-(int)getSyncable{
    return syncable;
}

- (void)setStartTime:(int)_id {
    startTime = _id;
}

- (int)getStartTime{
    return startTime;
}

-(NSArray*)getFriendIds{
    return friendIds;
}

-(void)setFriendIds:(NSArray*)_friends{
    friendIds = [[NSArray alloc] init];
    friendIds = _friends;
}


-(int)getFavourite {
    return favourite;
}
-(void)setFavourite:(int)_rate{
    favourite = _rate;
}
@end
