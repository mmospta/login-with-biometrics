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
    @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
    @KeyChain(key: "use_face_password", account: "FaceIDLogin") var storedPassword
    @AppStorage("log_status") var logStatus: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    func loginUser(useFaceID: Bool, email: String = "", password: String = "") async throws {
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email : self.email, password: password != "" ? password : self.password)
        DispatchQueue.main.async {
            if useFaceID && self.storedEmail == nil {
                self.useFaceID = useFaceID
                let emailData = self.email.data(using: .utf8)
                let passwordData = self.password.data(using: .utf8)
                
                self.storedEmail = emailData
                self.storedPassword = passwordData
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
        if let emailData =  storedEmail, let passwordData = storedPassword, status {
            try await loginUser(useFaceID: useFaceID, email: String(data: emailData, encoding: .utf8) ?? "", password: String(data: passwordData, encoding: .utf8) ?? "")
        }
    }
}
