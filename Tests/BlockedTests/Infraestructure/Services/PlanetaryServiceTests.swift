//
//  PlanetaryServiceTests.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation
@testable import Blocked
import XCTest

class PlanetaryServiceTests: XCTestCase {

    var urlSession: URLSession!
    var service: PlanetaryService!

    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        urlSession = URLSession(configuration: configuration)

        service = PlanetaryService(session: urlSession)
    }

    func testRetrieveBlockedList() {
        let token = "testToken"

        var lastRequest: URLRequest?
        URLProtocolMock.requestHandler = { request in
            lastRequest = request
            let exampleData = "[\"key1\", \"key2\"]".data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, exampleData)
        }

        let expectation = XCTestExpectation()
        service.retreiveBlockedList(token: token) { identities, error in
            XCTAssertNil(error)
            XCTAssertNotNil(lastRequest)
            let header = lastRequest?.value(forHTTPHeaderField: "X-Planetary-Bearer-Token")
            XCTAssertNotNil(header)
            XCTAssertEqual(header!, "testToken")
            XCTAssertEqual(identities.count, 2)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

