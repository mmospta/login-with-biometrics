//
//  LoginViewModel.swift
//  Biometrics-login
//
//  Created by Phonthep Aungkanukulwit on 3/1/2565 BE.
//

import SwiftUI
import Firebase
import LocalAuthentication

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var faceIDPassword: String = ""
    @AppStorage("log_status") var logStatus: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    func loginUser(useFaceID: Bool, email: String = "", password: String = "") async throws {
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email : self.email, password: password != "" ? password : self.password)
        DispatchQueue.main.async {
            if useFaceID && self.faceIDEmail == "" {
                self.useFaceID = useFaceID
                self.faceIDEmail = self.email
                self.faceIDPassword = self.password
            }
            self.logStatus = true
        }
    }
    
    func getBioMetricStatus() -> Bool {
        let scanner = LAContext()
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    func authenticateUser() async throws {
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login Into App")
        if status {
            try await loginUser(useFaceID: useFaceID, email: self.faceIDEmail, password: self.faceIDPassword)
        }
    }
}
