//
//  BlockedServiceAdapter.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation
import Logger

class BlockedServiceAdapter: BlockedService {

    var api: APIService

    init(api: APIService) {
        self.api = api
    }

    func updateToken(_ token: String, expires: Date) {
        TokenStore.shared.update(token, expires: expires)
    }

    func retreiveBlockedList(completion: @escaping (([Identity], BlockedError?) -> Void)) {
        guard let token = TokenStore.shared.current() else {
            // TODO: this blocks indefinitly. might want to add a timeout?!
            TokenStore.shared.register { [api] token in
                api.retreiveBlockedList(token: token, completion: completion)
            }
            return
        }
        api.retreiveBlockedList(token: token, completion: completion)
    }

}
