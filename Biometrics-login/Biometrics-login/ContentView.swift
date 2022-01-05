//
//  ContentView.swift
//  Biometrics-login
//
//  Created by Phonthep Aungkanukulwit on 3/1/2565 BE.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
    
    var body: some View {
        NavigationView {
            if logStatus {
                Home()
                    .onTapGesture {
                        print(storedEmail)
                    }
            } else {
                LoginPage()
                    .navigationBarHidden(true)
                    .onTapGesture {
                        print(storedEmail)
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
