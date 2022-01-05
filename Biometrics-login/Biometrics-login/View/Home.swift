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
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var faceIDPassword: String = ""
    
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
                    faceIDEmail = ""
                    faceIDPassword = ""
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
