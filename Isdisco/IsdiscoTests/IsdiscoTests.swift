//
//  IsdiscoTests.swift
//  IsdiscoTests
//
//  Created by Rasmus Gregersen on 13/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import XCTest
@testable import Isdisco
import Alamofire

class IsdiscoTests: XCTestCase {
    



    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

    }
    
    func testMusicRequestCount() {
        let expectation = XCTestExpectation(description: "Download music requests")
        var musicRequests = [MusicRequest]()
        let musicRequestAPI = MusicReqeustAPIRequest()
        musicRequestAPI.fetchMusicRequests() { response in
            musicRequests = response
            XCTAssertEqual(musicRequests.count > 0, true)
            expectation.fulfill()
        }
        XCTWaiter().wait(for: [expectation], timeout: 10)
    }
    
    
//    func testSearch() {
//        let expectation = XCTestExpectation(description: "Download music searches")
//        var searchResults = [Track]()
//        let apiRequest = SearchAPIRequest()
//        apiRequest.search(textToSearch: "a", completionHandler: {
//            [weak self] results, error in if case .failure = error {
//                return
//            }
//
//            guard let results = results, !results.isEmpty else {
//                return
//            }
//
//            for result in results {
//                searchResults.append(Track.jsonToObject(json: result))
//            }
//            XCTAssertEqual(searchResults.count > 0, true)
//        })
//
//        XCTWaiter().wait(for: [expectation], timeout: 10)
//    }
    
//    func testEmptyMusicRequestCount() {
//        let test = TestAPI()
//        test.resetList()
//
//
//        let musicRequestAPI = MusicReqeustAPIRequest()
//        var musicRequests = [MusicRequest]()
//        musicRequestAPI.FetchMusicRequests() { response in
//            musicRequests = response
//        }
//        XCTAssertEqual(musicRequests.count == 0, true)
//    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
//        let expectation = XCTestExpectation(description: "Download music requests")
        var musicRequests = [MusicRequest]()
        let musicRequestAPI = MusicReqeustAPIRequest()
        self.measure {
            // Put the code you want to measure the time of here.
            let expectation = XCTestExpectation(description: "Download music requests")
            musicRequestAPI.fetchMusicRequests() { response in
                musicRequests = response
                XCTAssertEqual(musicRequests.count > 0, true)
                expectation.fulfill()
            }
            XCTWaiter().wait(for: [expectation], timeout: 10)
        }
    }

}
