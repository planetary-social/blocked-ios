//
//  BlockedServiceAdapterTests.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import XCTest
@testable import Blocked

final class BlockedServiceAdapterTests: XCTestCase {

    private var api: APIServiceMock!
    private var service: BlockedServiceAdapter!

    override func setUp() {
        api = APIServiceMock()
        service = BlockedServiceAdapter(api: api)
    }

    func testRetrieveBlockedList() {
        service.retreiveBlockedList { _,_ in }
        XCTAssertTrue(api.retrieved)
    }
}
