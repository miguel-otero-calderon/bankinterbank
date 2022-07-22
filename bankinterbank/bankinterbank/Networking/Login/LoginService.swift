//
//  LoginService.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation
import Alamofire

protocol LoginServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<Login, Error>) -> Void)
}

class LoginService: LoginServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<Login, Error>) -> Void) {
        let userHard = "ADMIN"
        let passwordHard = "admin"
        
        if email.uppercased() == userHard && password == passwordHard {
            let login = Login(username: "Administrador", email: email, password: password)
            UserDefaults.standard.setValue(login.username, forKey: "username")
            UserDefaults.standard.setValue(login.email, forKey: "email")
            completion(.success(login))
        } else {
            if email.uppercased() != userHard {
                completion(.failure(LoginError.userNotExist))
            } else if password != passwordHard {
                completion(.failure(LoginError.passwordIncorrect))
            }
        }
    }
}

