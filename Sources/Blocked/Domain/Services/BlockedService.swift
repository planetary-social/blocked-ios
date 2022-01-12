//
//  BlockedService.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation

protocol BlockedService {

    func updateToken(_ token: String, expires: Date)

    func retreiveBlockedList(completion: @escaping (([Identity], BlockedError?) -> Void))

}
