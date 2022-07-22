//
//  LoginValidationsUseCase.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation

struct LoginValidationsUseCase {
    
    let login: Login
    
    public init(login: Login) {
        self.login = login
    }
    
    func getValidatedPassword() -> String {
        if self.login.password == "" {
            return "Password empty"
        }
        if self.login.password.count <= 6 {
            return "Enter password greater than 6 characters"
        }
        return ""
    }
    
    func getValidatedUser() -> String {
        if self.login.email == "" {
            return "User empty"
        }
        if self.login.email.count <= 4 {
            return "Enter password greater than 4 characters"
        }
        return ""
    }
}

