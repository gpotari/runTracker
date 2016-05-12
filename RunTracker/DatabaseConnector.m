//
//  DatabaseConnector.m
//  InterMap
//
//  Created by Pótári Gábor on 2014. 11. 12..
//  Copyright (c) 2014. Intermap. All rights reserved.
//

#import "DatabaseConnector.h"

#import <sqlite3.h>
#include <spatialite.h>

#include "Tour.h"
#include "DataProvider.h"

@implementation DatabaseConnector
@synthesize localMasterDataIds;


+ (id)databaseConnector{
    static DatabaseConnector* databaseConnector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        databaseConnector = [[self alloc] init];
    });
  
    
    return databaseConnector;
}

- (id)init {
    self = [super init];
    
    return self;
}

-(bool) connectToDatabase{

    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3_stmt *sqlStatement;
    sqlite3* db;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:databasePath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"RT" ofType:@"db"];
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:databasePath error:&error]) {
            NSLog(@"Error: %@", error);
        }
    }
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
        return false;
    }
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        NSLog(@"Database Successfully Opened :)");
    }
    
    sqlite3_finalize(sqlStatement);
    sqlStatement = nil;
    sqlite3_close(db);
    db = nil;
    
    
   sqlStatement = nil; db = nil;
    
    return true;
}
    
////Túrák kigyüjtése lokális adatbázisból
-(int)getRoadCount {
   
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3_stmt *sqlStatement;
    sqlite3* db;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
        return false;
    }
    
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);
    const char* query = "select * from geoRoad";
    
    

    

    if(sqlite3_prepare(db, query, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    int count = 0;
    while ( sqlite3_step(sqlStatement)==SQLITE_ROW) {
        count++;
    }
    
    sqlite3_finalize(sqlStatement); sqlStatement = nil; db = nil;
    return count;
}


////elkezdtünk egy új track-et
-(void)insertNewTrack{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3* db;
    char *errMsg;
    sqlite3_stmt *sqlStatement = nil;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
    }

    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
         NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);

    NSString* query = [[@"INSERT INTO 'geoRoad' (Tracked,Syncable,Active,DifficultyDataId,StartTime) VALUES (1,1,1,0," stringByAppendingString:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]] stringByAppendingString:@")"];
    
    
    if(sqlite3_prepare(db, [query UTF8String], -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    sqlite3_exec(db, [query UTF8String] , NULL, NULL, &errMsg);
   // sqlite3_step(sqlStatement);
    
    
    //Lekérdezzük az új azonosítót
    const char* newIdQuery =  "select max(Id) from geoRoad";
    
    sqlStatement = nil;
    
    if(sqlite3_prepare(db, newIdQuery, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    while ( sqlite3_step(sqlStatement)==SQLITE_ROW) {
        trackId = sqlite3_column_int(sqlStatement, 0);
    }

    sqlite3_finalize(sqlStatement);
    sqlStatement = nil;
    sqlite3_close(db);
    db = nil;
}


-(int)getTrackPointCount {
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3_stmt *sqlStatement;
    sqlite3* db;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
        return false;
    }
    
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);
    const char* query = "select * from geoRoadPoint";
    
    
    
    
    
    if(sqlite3_prepare(db, query, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    int count = 0;
    while ( sqlite3_step(sqlStatement)==SQLITE_ROW) {
        count++;
    }
    
    sqlite3_finalize(sqlStatement); sqlStatement = nil; db = nil;
    return count;
}

//
////Elmentünk egy mért pontot
-(void)insertNewTrackPoint:(CLLocation*)coord{
  //  CLLocationCoordinate2D c = coord;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3* db;
    char *errMsg;
    sqlite3_stmt *sqlStatement = nil;
    
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
    }
    
    
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
       // NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);
    
    NSString* query = [[[[[[[[[[@"INSERT INTO geoRoadPoint (Road_Id,Lat,Lon,Ele,Time) VALUES (" stringByAppendingString:[NSString stringWithFormat:@"%i",trackId] ] stringByAppendingString:@","] stringByAppendingString:[NSString stringWithFormat:@"%f",coord.coordinate.latitude]] stringByAppendingString:@","] stringByAppendingString:[NSString stringWithFormat:@"%f",coord.coordinate.longitude]] stringByAppendingString:@","] stringByAppendingString:[NSString stringWithFormat:@"%f",coord.altitude]] stringByAppendingString:@","] stringByAppendingString:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]] stringByAppendingString:@")"];
    
    //NSLog(@"%@",query);
    if(sqlite3_prepare(db, [query cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    sqlite3_exec(db, [query cStringUsingEncoding:NSASCIIStringEncoding] , NULL, NULL, &errMsg);
   // sqlite3_step(sqlStatement);
    
    sqlite3_finalize(sqlStatement);
    sqlStatement = nil;
    sqlite3_close(db);
    
}

////befejeztük a trackelést
-(void)saveTrack:(NSString*)name comment:(NSString*)comment description:
(NSString*)_description  {
    NSLog(@"%@",name) ;

    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3* db;
    char *errMsg;
    sqlite3_stmt *sqlStatement = nil;
    NSString* coordString = @"";

    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
    }
    
    
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        // NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);
    //Kivesszük a trackelt pontokat
    NSString* query =  [@"select * from geoRoadPoint where Road_Id = " stringByAppendingString:[NSString stringWithFormat:@"%i",trackId]] ;
    
    sqlStatement = nil;
    
    if(sqlite3_prepare(db, [query cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    int roadPointCount = 0;
    while ( sqlite3_step(sqlStatement)==SQLITE_ROW) {
        roadPointCount++;
        CLLocation* currentLoc = [[CLLocation alloc] initWithLatitude:sqlite3_column_double(sqlStatement, 4) longitude:sqlite3_column_double(sqlStatement, 3)];
       
        coordString = [[[[coordString stringByAppendingString:@","] stringByAppendingString:[NSString stringWithUTF8String:sqlite3_column_text(sqlStatement,4)]] stringByAppendingString:@" " ] stringByAppendingString:[NSString stringWithUTF8String:sqlite3_column_text(sqlStatement,3)]];
        
    }
    sqlite3_finalize(sqlStatement);
    coordString = [coordString substringFromIndex:1];
    sqlStatement = nil;
    
    DataProvider* dataProvider = [DataProvider dataProvider];
    float length = [dataProvider getDistance];
    int time = [dataProvider getTime];
    
    //elmentjük a trackelt túrát
    query = [[[[[[[[[[[[[[@"update geoRoad set Description = '', Time = " stringByAppendingString:[NSString stringWithFormat:@"%i",time]] stringByAppendingString:@", Length = " ] stringByAppendingString:[NSString stringWithFormat:@"%f",length]] stringByAppendingString:@", Type_Id = 1"] stringByAppendingString:@", Color = 4665733, ShortDesc = '" ] stringByAppendingString:_description] stringByAppendingString:@"', Name ='" ] stringByAppendingString:name ] stringByAppendingString:@"', EndTime = "] stringByAppendingString:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]] stringByAppendingString:@", Geographic = GeomFromText('LINESTRING("] stringByAppendingString:coordString] stringByAppendingString: @")',4326) where Id = "] stringByAppendingString:[NSString stringWithFormat:@"%i",trackId]];
    
    sqlite3_exec(db, [query UTF8String] , NULL, NULL, &errMsg);
    //sqlite3_step(sqlStatement);
    [dataProvider setDistance:0];
    sqlite3_finalize(sqlStatement);
    sqlStatement = nil;
    sqlite3_close(db);
    db = nil;
    
}


-(double)getMinDistFromDB {
    
    double res = 0.0;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3* db;
    char *errMsg;
    sqlite3_stmt *sqlStatement = nil;
    NSString* coordString = @"";
    
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
    }
    
     if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        // NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);
    //Kivesszük a trackelt pontokat
    NSString* query =  @"select Length from geoRoad order by Length ";
    
    sqlStatement = nil;
    
    if(sqlite3_prepare(db, [query cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    sqlite3_step(sqlStatement);
    res =  sqlite3_column_double(sqlStatement, 0);
    
    sqlite3_finalize(sqlStatement);
    sqlStatement = nil;
    sqlite3_close(db);
    db = nil;

    return res;
}


-(double)getMaxDistFromDB {
    
    double res = 0.0;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3* db;
    sqlite3_stmt *sqlStatement = nil;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
    }
    
    
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        // NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);
    
    //kiválasztjuk a trackeket hosszuk szerint csökkenőben
    NSString* query =  @"select Length from geoRoad order by Length desc ";
    
    sqlStatement = nil;
    
    if(sqlite3_prepare(db, [query cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    sqlite3_step(sqlStatement);
    
    //a legelső a leghosszabb
    res =  sqlite3_column_double(sqlStatement, 0);
    
    sqlite3_finalize(sqlStatement);
    sqlStatement = nil;
    sqlite3_close(db);
    db = nil;
    
    return res;
}

-(double)getTodayDistFromDB {
    double res = 0.0;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3* db;
    sqlite3_stmt *sqlStatement = nil;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
    }
    
    
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        // NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);
    
    
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970] * 1000 - hour*3600000 - minute*60000;
    

    NSString* query =  [@"select Length from geoRoad where StartTime > " stringByAppendingString:[NSString stringWithFormat:@"%f",timeInMiliseconds]];
    
    sqlStatement = nil;
    
    if(sqlite3_prepare(db, [query cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    while ( sqlite3_step(sqlStatement)==SQLITE_ROW) {
        res +=  sqlite3_column_double(sqlStatement, 0);
    }
    
    sqlite3_finalize(sqlStatement);
    sqlStatement = nil;
    sqlite3_close(db);
    db = nil;
    
    return res;

}



-(double)getThisWeekDistFromDB {
    double res = 0.0;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3* db;
    sqlite3_stmt *sqlStatement = nil;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"RT.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
    }
    
    
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        // NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);
    
    
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    
    
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970] * 1000 - hour*3600000 - minute*60000 - [comps weekday]*24*3600000 ;
    
    NSString* query =  [@"select Length from geoRoad where StartTime > " stringByAppendingString:[NSString stringWithFormat:@"%f",timeInMiliseconds]];
    
    sqlStatement = nil;
    
    if(sqlite3_prepare(db, [query cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    while ( sqlite3_step(sqlStatement)==SQLITE_ROW) {
        res +=  sqlite3_column_double(sqlStatement, 0);
    }
    
    sqlite3_finalize(sqlStatement);
    sqlStatement = nil;
    sqlite3_close(db);
    db = nil;
    
    return res;
    
}




-(NSMutableArray*)getRoadsFromLocalDatabase {
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    sqlite3_stmt *sqlStatement;
    sqlite3* db;
    
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [libraryPath stringByAppendingPathComponent:@"dszt.db"];
    
    bool success = [fileMgr fileExistsAtPath:databasePath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", databasePath);
        return false;
    }
    
    
    if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
        NSLog(@"Database Successfully Opened :)");
    }
    spatialite_init_ex(db,NULL,1);
    const char* query = "select r.Id,r.Name,r.Color,r.Time,r.Length,r.ShortDesc,r.Description,AsText(r.Geographic),r.Type_Id,r.FirstPictureId,r.PictureIds,r.Syncable,r.StartTime,r.Favourite from geoRoad r join coMasterData c on r.Type_Id = c.Id where c.Id is not null and ( Syncable is null or (Syncable = 1 AND EndTime is not null))";
    
    
    if(sqlite3_prepare(db, query, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        NSLog(@"Problem with prepare statement");
    }
    
    while ( sqlite3_step(sqlStatement)==SQLITE_ROW) {
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@")(\""];
        NSString* latlongString = [[[NSString alloc] initWithUTF8String:sqlite3_column_text(sqlStatement, 7)]
                                   stringByReplacingOccurrencesOfString:@"\\n" withString:@" "];
        latlongString  = [[latlongString componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
        latlongString = [latlongString stringByReplacingOccurrencesOfString:@"LINESTRING" withString:@""];
        latlongString = [latlongString stringByReplacingOccurrencesOfString:@"MULTI" withString:@""];
        
        NSArray *roadCoords = [latlongString componentsSeparatedByString:@", "];
        
        NSMutableArray* coordinates = [[NSMutableArray alloc] init];
        for(int i=0;i<roadCoords.count;++i){
            NSArray *coordsString = [roadCoords[i] componentsSeparatedByString:@" "];
            CLLocation* location = [[CLLocation alloc] initWithLatitude:[coordsString[1] floatValue] longitude:[coordsString[0] floatValue]];
            
            [coordinates addObject:location];
        }
        
        //túra típusának kigyűjtése
        sqlite3_stmt* typeSqlStmt;
        NSString* typeQuery = [@"select Name from coMasterData where Id = " stringByAppendingString:[[NSString alloc] initWithUTF8String:sqlite3_column_text(sqlStatement,8)]] ;
        
        if(sqlite3_prepare(db, [typeQuery UTF8String], -1, &typeSqlStmt, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        Tour *tour = [[Tour alloc] init];
        while ( sqlite3_step(typeSqlStmt)==SQLITE_ROW) {
            [tour setType:[[NSString alloc] initWithUTF8String:sqlite3_column_text(typeSqlStmt,0)]];
        }
        
        [tour setName:[[NSString alloc] initWithUTF8String:sqlite3_column_text(sqlStatement,1)]];
        [tour setId:sqlite3_column_int(sqlStatement, 0)];
        [tour setTypeId:sqlite3_column_int(sqlStatement,8)];
        [tour setCount:roadCoords.count];
        [tour setCoordinates:coordinates];
        [tour setTime:sqlite3_column_int(sqlStatement, 3)];
        [tour setColor:sqlite3_column_int(sqlStatement, 2)];
        [tour setLength:sqlite3_column_double(sqlStatement, 4)];
        [tour setShortDesc:[[NSString alloc] initWithUTF8String:sqlite3_column_text(sqlStatement,5)]];
        [tour setDescription:@" "];//[[NSString alloc] initWithUTF8String:sqlite3_column_text(sqlStatement,6)]];
        
        
        [tour setSyncable:sqlite3_column_int(sqlStatement, 11)];
        [tour setStartTime:sqlite3_column_int(sqlStatement, 12)];
        [tour setFavourite:sqlite3_column_int(sqlStatement, 13)];
        
        
        [resultArray addObject:tour];
        
    }
    return resultArray;
}


@end





