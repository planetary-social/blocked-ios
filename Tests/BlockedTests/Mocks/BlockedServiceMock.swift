//
//  BlockedServiceMock.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation
@testable import Blocked

class BlockedServiceMock: BlockedService {
    
    var retrieved = false
    var tokenUpdated = false

    func updateToken(_ token: String, expires: Date) {
        tokenUpdated = true
    }

    func retreiveBlockedList(completion: @escaping (([Identity], BlockedError?) -> Void)) {
        retrieved = true
    }

}
