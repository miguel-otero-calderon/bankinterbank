//
//  Login.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation
struct Login: Codable {
    let username: String
    let email: String
    let password: String
}
enum LoginError: Error {
    case userNotExist
    case passwordIncorrect
    
}
