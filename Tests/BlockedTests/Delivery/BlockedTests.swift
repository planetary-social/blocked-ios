//
//  BlockedTests.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation
import XCTest
@testable import Blocked

final class BlockedTests: XCTestCase {

    private var service: BlockedServiceMock!
    private var blocked: Blocked!

    override func setUp() {
        service = BlockedServiceMock()
        blocked = Blocked(service: service)
    }

    func testRetrieveBlockedList() {
        blocked.retrieveBlockedList { _,_ in }
        XCTAssertTrue(service.retrieved)
    }
}
