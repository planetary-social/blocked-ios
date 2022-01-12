//
//  APIService.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation

protocol APIService {

    func retreiveBlockedList(token: String, completion: @escaping (([Identity], BlockedError?) -> Void))

}
