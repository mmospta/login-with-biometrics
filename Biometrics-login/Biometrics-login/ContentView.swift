//
//  ContentView.swift
//  Biometrics-login
//
//  Created by Phonthep Aungkanukulwit on 3/1/2565 BE.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        NavigationView {
            if logStatus {
                Home()
            } else {
                LoginPage()
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
