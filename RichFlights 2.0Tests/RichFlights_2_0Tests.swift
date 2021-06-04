//
//  RichFlights_2_0Tests.swift
//  RichFlights 2.0Tests
//
//  Created by Tendaishe Gwini on 4/27/21.
//

import XCTest
@testable import RichFlights_2_0

class RichFlights_2_0Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    ///Test whether utcCorrection function in TrackedFlightStatusModel is working correctly
    ///
    ///This test is to ensure that the time difference between the test string and corrected string is equivalent to the controlTimeDifference between the different regions.
    
    
    func testUTCCorrection() {
        
        let controlDate = Date()
        
        let calendar = Calendar(identifier: .gregorian)
        let gmtHour = calendar.dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: controlDate).hour!
        let edtHour = calendar.dateComponents(in: TimeZone(identifier: "America/New_York")!, from: controlDate).hour!
        let controlTimeDifference = edtHour - gmtHour
        
        
        let randomSeconds = Double.random(in: -1000000...1000000)
        let testDate = Date().addingTimeInterval(randomSeconds)
        let iso8601Formatter = ISO8601DateFormatter()
        let isoTestDateString = iso8601Formatter.string(from: testDate)
        
        let correctedString = TrackedFlightStatusModel.utcCorrection(time: isoTestDateString)
        
        let correctedDate = iso8601Formatter.date(from: correctedString)!
        
        let testHour = calendar.dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: testDate).hour!
        let correctedHour = calendar.dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: correctedDate).hour!
        let correctedTimeDifference = testHour - correctedHour
        
        XCTAssert(controlTimeDifference == correctedTimeDifference)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
