//
//  Home.swift
//  Biometrics-login
//
//  Created by Phonthep Aungkanukulwit on 3/1/2565 BE.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    @AppStorage("use_face_id") var useFaceID: Bool = false
    
    @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
    @KeyChain(key: "use_face_password", account: "FaceIDLogin") var storedPassword
    
    var body: some View {
        VStack(spacing: 20) {
            if logStatus {
                Text("Logged In")
                Button("Logout") {
                    try? Auth.auth().signOut()
                    logStatus = false
                }
            } else {
                Text("Came as guest")
            }
            
            if useFaceID {
                Button("Disable Face ID") {
                    useFaceID = false
                    storedEmail = nil
                    storedPassword = nil
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
