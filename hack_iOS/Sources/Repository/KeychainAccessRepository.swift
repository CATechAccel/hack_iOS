//
//  KeychainAccessRepository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/20.
//

import Foundation
import KeychainAccess

struct KeychainAccessRepository {
    let keychain = Keychain(service: "CTAhack_iOS.hack_iOS")
    
    func save(token: String) {
        keychain["token"] = token
    }
    
    func get() -> String? {
        let token = keychain["token"]
        return token
    }
}
