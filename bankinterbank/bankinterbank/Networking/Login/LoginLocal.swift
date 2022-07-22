//
//  LoginLocal.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation

protocol LoginLocalProtocol {
    func existsLogin() -> Bool
}

class LoginLocal: LoginLocalProtocol {
    func existsLogin() -> Bool {
        guard let _ = UserDefaults.standard.string(forKey: "email") else {
            return false
        }
        return true
    }
}
