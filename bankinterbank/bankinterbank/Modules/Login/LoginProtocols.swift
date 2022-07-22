//
//  LoginProtocols.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation
import UIKit

protocol LoginRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
    
    func signIn(email: String,password: String,completion: @escaping (Result<Login, Error>) -> Void)
}

protocol LoginRemoteDataManagerOutputProtocol: AnyObject {
}

protocol LoginLocalDataManagerInputProtocol: AnyObject {
    func existsLogin() -> Bool
}

