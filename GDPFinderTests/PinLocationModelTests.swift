//
//  PinLocationModelTests.swift
//  GDPFinderTests
//
//  Created by Nafisa Rahman on 1/9/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import XCTest
import MapKit
@testable import GDPFinder

class PinLocationDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPinLocationData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let myPinDataModel = PinLocationModel(title: "pin", coordinate: CLLocationCoordinate2D(latitude: -37.837529417944396, longitude: 144.984269057738))
        
        XCTAssertNotNil(myPinDataModel)
        
        XCTAssertEqual(myPinDataModel.title, "pin", "Titles are not equal")
        
        XCTAssertEqual(myPinDataModel.coordinate.latitude,  CLLocationCoordinate2D(latitude: -37.837529417944396, longitude: 144.984269057738).latitude, "latitudes are not equal")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

