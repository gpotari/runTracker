//
//  RunTrackerUnitTest.m
//  RunTracker
//
//  Created by Potari Gabor on 2016. 05. 10..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SettingsViewController.h"
#import "StatisticViewController.h"

#import "DatabaseConnector.h"
#import "DataProvider.h"

@interface RunTrackerUnitTest : XCTestCase

@end

@implementation RunTrackerUnitTest

DatabaseConnector* databaseConnector;
DataProvider* dataProvider;

- (void)setUp {
    
    [super setUp];
     databaseConnector = [DatabaseConnector databaseConnector];
     dataProvider = [DataProvider dataProvider];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    
    //Road insert, select
    int count = [databaseConnector getRoadCount];
    [databaseConnector insertNewTrack];
    XCTAssertEqualObjects( [NSNumber numberWithInt:[databaseConnector getRoadCount]], [NSNumber numberWithInt:count+1]);
    
    //road point insert , select
    count = [databaseConnector getTrackPointCount];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:11.0 longitude:33.0];
    [databaseConnector insertNewTrackPoint:loc];
    XCTAssertEqualObjects( [NSNumber numberWithInt:[databaseConnector getTrackPointCount]], [NSNumber numberWithInt:count+1]);
    
    //today statistic - dataProvider length
    double today = [databaseConnector getTodayDistFromDB];
    [databaseConnector insertNewTrack];
    [dataProvider setDistance:44.0];
    [databaseConnector insertNewTrackPoint:loc];
    [databaseConnector saveTrack:@"teszt" comment:@"teszt" description:@"teszt"];
    XCTAssertEqualObjects( [NSNumber numberWithInt:[databaseConnector getTodayDistFromDB]], [NSNumber numberWithInt:today+44.0]);
    
    //week statistic
    double week = [databaseConnector getThisWeekDistFromDB];
    [databaseConnector insertNewTrack];
    [dataProvider setDistance:100.0];
    [databaseConnector insertNewTrackPoint:loc];
    [databaseConnector saveTrack:@"teszt" comment:@"teszt" description:@"teszt"];
    XCTAssertEqualObjects( [NSNumber numberWithInt:[databaseConnector getThisWeekDistFromDB]], [NSNumber numberWithInt:week+100.0]);
    
    //
    //max statistic
    [databaseConnector insertNewTrack];
    [dataProvider setDistance:10000000];
    [databaseConnector insertNewTrackPoint:loc];
    [databaseConnector saveTrack:@"teszt" comment:@"teszt" description:@"teszt"];
    XCTAssertEqualObjects( [NSNumber numberWithInt:[databaseConnector getMaxDistFromDB]], [NSNumber numberWithInt:1000000]);
    
    //min statistic
    [databaseConnector insertNewTrack];
    [dataProvider setDistance:0];
    [databaseConnector insertNewTrackPoint:loc];
    [databaseConnector saveTrack:@"teszt" comment:@"teszt" description:@"teszt"];
    XCTAssertEqualObjects( [NSNumber numberWithInt:[databaseConnector getMinDistFromDB]], [NSNumber numberWithInt:0]);
    
    
}


-(void)databaseHandlerTest {
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
