//
//  HexEncoder.swift
//  
//
//  Created by Martin Dutra on 12/1/22.
//

import Foundation

class HexEncoder {

    func encode(data: Data) -> String {
        // Borrowed from Stack Overflow
        // https://stackoverflow.com/questions/8798725/get-device-token-for-push-notification
        return data.reduce("", {$0 + String(format: "%02X", $1)})
    }

}
