//
//  LoginPage.swift
//  Biometrics-login
//
//  Created by Phonthep Aungkanukulwit on 3/1/2565 BE.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    @State var useFaceID: Bool = false
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.5)
                .fill(.black)
                .frame(width: 45, height: 45)
                .rotationEffect(.degrees(-90.0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: -23)
            
            Text("Hey, \nLogin Now")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Email", text: $loginModel.email)
                .textInputAutocapitalization(.none)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.email == "" ? Color.black.opacity(0.05) : Color("Yellow")
                        )
                }
            
            SecureField("Password", text: $loginModel.password)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginModel.password == "" ? Color.black.opacity(0.05) : Color("Yellow")
                        )
                }
                .textInputAutocapitalization(.none)
                .padding(.top, 15)
            
            if loginModel.getBioMetricStatus() {
                Group {
                    if loginModel.useFaceID  {
                        Button {
                            Task {
                                do {
                                    try await loginModel.authenticateUser()
                                } catch {
                                    loginModel.errorMsg = error.localizedDescription
                                    loginModel.showError.toggle()
                                }
                            }
                        } label: {
                            VStack(alignment: .center, spacing: 10) {
                                Label {
                                    Text("Use FaceID to login into previous account")
                                } icon: {
                                    Image(systemName: "faceid")
                                }
                                .font(.caption)
                                
                                Text("You can turn off it in settings!")
                                    .font(.caption2)
                            }
                        }
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                        
                    } else {
                        Toggle(isOn: $useFaceID) {
                            Text("Use Face ID to Login")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.vertical, 20)
            }
            
            
            Button {
                // Action something
                Task {
                    do {
                        try await loginModel.loginUser(useFaceID: useFaceID)
                    } catch {
                        loginModel.errorMsg = error.localizedDescription
                        loginModel.showError.toggle()
                    }
                }
            } label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Red"))
                    }
            }
            .padding(.vertical, 35)
            .disabled(loginModel.email == "" || loginModel.password == "")
            .opacity(loginModel.email == "" || loginModel.password == "" ? 0.5 : 1)
            
            NavigationLink {
                // Destination
            } label: {
                Text("Skip")
                    .foregroundColor(.gray)
            }

        }
        .padding(.horizontal, 25)
        .padding(.vertical)
        .alert(loginModel.errorMsg, isPresented: $loginModel.showError) {
            
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
