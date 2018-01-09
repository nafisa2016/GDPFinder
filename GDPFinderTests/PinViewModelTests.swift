//
//  PinViewModelTests.swift
//  GDPFinderTests
//
//  Created by Nafisa Rahman on 1/9/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import XCTest
@testable import GDPFinder

class PinViewModelTests: XCTestCase {
    
    var pinViewModel : PinViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        pinViewModel = PinViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetCurrentYear() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let year = pinViewModel.getCurrentYear()
        XCTAssertEqual(2018, year)
        
    }
    
    func testFormattedGDP() {
        
        let formattedGDP = pinViewModel.formatGDP(145900000, gdpYear: "2016")!
        XCTAssertEqual(formattedGDP, "145,900,000 (2016)")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

