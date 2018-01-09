//
//  ViewControllerTests.swift
//  GDPFinderTests
//
//  Created by Nafisa Rahman on 1/9/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import XCTest
import MapKit
@testable import GDPFinder

class ViewControllerTests: XCTestCase  {
    
    var viewController : ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        //set up UIWindow hierarchy
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
        viewController.loadView()
        viewController.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //test whether mapview exists
    func testMapViewExists() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(viewController.mapView)
    }
    
    //test whether conform to MKMapViewDelegate protocol
    func testControllerConformsToMKMapViewDelegate() {
        
        XCTAssert(viewController.conforms(to: MKMapViewDelegate.self), "ViewController under test does not conform to MKMapViewDelegate protocol")
    }
    
    func testConformsToAddPinHandlerProtocol(){
        
        XCTAssert(viewController.conforms(to: PinHandler.self))
    }
    
    //test whether mapview delegate is set
    func testMapViewDelegateIsSet() {
        
        XCTAssertNotNil(self.viewController.mapView.delegate)
    }
    
    //test whether pinViewModel delegate is set
    func testPinViewModelDelegateIsSet() {
        
        XCTAssertNotNil(self.viewController.pinViewModel.delegate)
        
    }
    
    //pinViewModel.handleISOCountry.GDPdelegate
    func testhandleISOCountryDelegateIsSet() {
        XCTAssertNotNil(self.viewController.pinViewModel.handleISOCountry.GDPdelegate)
        
    }
    
    //pinViewModel.fetchGDP.GDPdelegate
    func testPinViewModelfetchGDPDelegateIsSet() {
        XCTAssertNotNil(self.viewController.pinViewModel.fetchGDP.GDPdelegate)
        
    }
    
    //test add pin
    func testControllerAddsAnnotationsToMapView() {
        
        viewController.addPin(touchedPt: PinLocationModel(title: "GDP", coordinate: CLLocationCoordinate2D(latitude: -90.0, longitude: 90.0)))
        let annotationsOnMap = self.viewController.mapView.annotations
        XCTAssertEqual(annotationsOnMap.count, 1)
        
    }
    
    //test remove pin
    func testRemovePin() {
        
        let pin = PinLocationModel(title: "GDP", coordinate: CLLocationCoordinate2D(latitude: -90.0, longitude: 90.0))
        
        viewController.mapView.addAnnotation(pin)
        var annotationsOnMap = self.viewController.mapView.annotations
        XCTAssertEqual(annotationsOnMap.count, 1)
        
        viewController.removePin()
        annotationsOnMap = self.viewController.mapView.annotations
        XCTAssertEqual(annotationsOnMap.count, 0)
    }
    
    //test whether segmented controller exists
    func testSegmentedControllerExists() {
        
        XCTAssertNotNil(viewController.mapType)
    }
    
    //test number of segments
    func testSegmentedControllerNumverOfSegments() {
        
        XCTAssertEqual(viewController.mapType.numberOfSegments,3)
    }
    
    func testSegmentTitles () {
        
        XCTAssertEqual(viewController.mapType.titleForSegment(at: 0),"Standard")
        XCTAssertEqual(viewController.mapType.titleForSegment(at: 1),"Satellite")
        XCTAssertEqual(viewController.mapType.titleForSegment(at: 2),"Hybrid")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

