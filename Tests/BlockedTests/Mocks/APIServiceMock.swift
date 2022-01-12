//
//  APIServiceMock.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation
@testable import Blocked

class APIServiceMock: APIService {

    var retrieved = false

    func retreiveBlockedList(token: String, completion: @escaping (([Identity], BlockedError?) -> Void)) {
        retrieved = true
    }

}
