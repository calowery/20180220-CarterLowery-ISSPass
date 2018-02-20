//
//  ISS_PassesTests.swift
//  ISS_PassesTests
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import XCTest
@testable import ISS_Passes

class ISS_PassesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetISSPosition() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        OpenNotify.getISSPosition { (position) in

        }
    }
    
    func testGetSpaceMen() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        OpenNotify.getSpaceMen { (spaceMen) in

        }
    }
    
    func testGetPassTimesNoAltitude() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        OpenNotify.getPassTimes(lat: 37.3323, lon: -122.031, alt: nil) { (passTimes) in

        }
    }
    
    func testGetPassTimesWithAltitude() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        OpenNotify.getPassTimes(lat: 37.3323, lon: -122.031, alt: 15.0) { (passTimes) in

        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
}
