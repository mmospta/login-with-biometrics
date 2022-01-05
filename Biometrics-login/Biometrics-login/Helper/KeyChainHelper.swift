//
//  KeyChainHelper.swift
//  Biometrics-login
//
//  Created by Phonthep Aungkanukulwit on 5/1/2565 BE.
//

import SwiftUI

class KeyChainHelper {
    
    static let standard = KeyChainHelper()
    
    func save(data: Data, key: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        switch status {
        case errSecSuccess:
            print("Success")
        case errSecDuplicateItem:
            let query = [
                kSecAttrAccount: account,
                kSecAttrService: key,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            let updateAttr = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, updateAttr)
        default:
            print("Error \(status)")
        }
    }
    
    func read(key: String, account: String) -> Data? {
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var resultData: AnyObject?
        SecItemCopyMatching(query, &resultData)
        
        return (resultData as? Data)
    }
    
    func delete(key: String, account: String) {
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    
}
