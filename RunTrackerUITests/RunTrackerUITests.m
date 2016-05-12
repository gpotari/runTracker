//
//  RunTrackerUITests.m
//  RunTrackerUITests
//
//  Created by Potari Gabor on 2016. 03. 04..
//  Copyright © 2016. Potari Gabor. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RunTrackerUITests : XCTestCase

@end

@implementation RunTrackerUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    
    
    XCUIApplication *app =  [[XCUIApplication alloc] init];
    XCUIElement *element = [[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    [element tap];
    
    [app.buttons[@"hamburger menu"] tap];
    [[[[[[element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:4] tap];
    
    XCUIElement *element2 = [[[element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element;
    [[[element2 childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:1] tap];
    
    XCUIElement *kilomTerPickerWheel = app.pickerWheels[@"Kilométer"];
    [kilomTerPickerWheel tap];
    [kilomTerPickerWheel tap];
    [[[element2 childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:2] tap];
    
    XCUIApplication *app2 = app;
    [app2.pickerWheels[@"Kék"] tap];
    [[[element2 childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:3] tap];
    [app2.pickerWheels[@"Hibrid"] tap];
    [app.buttons[@"MENTÉS"] tap];
    
    XCUIElement *okButton = app.alerts[@"Beállítások Mentése"].collectionViews.buttons[@"OK"];
    [okButton tap];
    [okButton tap];
    [okButton tap];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}




@end
