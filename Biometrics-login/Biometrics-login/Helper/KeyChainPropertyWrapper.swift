//
//  KeyChainPropertyWrapper.swift
//  Biometrics-login
//
//  Created by Phonthep Aungkanukulwit on 5/1/2565 BE.
//

import SwiftUI

@propertyWrapper
struct KeyChain: DynamicProperty  {
    @State var data: Data?
    
    var wrappedValue: Data? {
        get {
            KeyChainHelper.standard.read(key: key, account: account)
        }
        nonmutating set {
            guard let newData = newValue else {
                data = nil
                KeyChainHelper.standard.delete(key: key, account: account)
                return
            }
            KeyChainHelper.standard.save(data: newData, key: key, account: account)
            
            data = newValue
        }
    }
    
    var key: String
    var account: String
    
    init(key: String, account: String) {
        self.key = key
        self.account = account
        
        _data = State(wrappedValue: KeyChainHelper.standard.read(key: key, account: account))
    }
}
