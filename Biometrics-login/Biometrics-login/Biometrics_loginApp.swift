//
//  Biometrics_loginApp.swift
//  Biometrics-login
//
//  Created by Phonthep Aungkanukulwit on 3/1/2565 BE.
//

import SwiftUI
import Firebase

@main
struct Biometrics_loginApp: App {
    // MARK: Initialize Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
