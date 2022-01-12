//
//  Blocked.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation

public class Blocked {

    public static let shared = Blocked(service: BlockedServiceAdapter(api: PlanetaryService()))

    var service: BlockedService

    init(service: BlockedService) {
        self.service = service
    }

    public func updateToken(_ token: String, expires: Date) {
        service.updateToken(token, expires: expires)
    }
    
    public func retrieveBlockedList(completion: @escaping (([String], Error?) -> Void)) {
        service.retreiveBlockedList { identities, error in
            completion(identities.map{$0.identifier}, error)
        }
    }

}
