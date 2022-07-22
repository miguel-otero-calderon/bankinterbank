//
//  LoginInteractor.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
    
    func signIn(email: String,password: String,completion: @escaping (Result<Login, Error>) -> Void)
    func existsLogin() -> Bool
}


class LoginInteractor: LoginInteractorProtocol {

    // MARK: Properties
    weak var presenter: LoginPresenterProtocol?

    func signIn(email: String, password: String, completion: @escaping (Result<Login, Error>) -> Void) {
        let service = LoginService()
        service.signIn(email: email, password: password, completion: completion)
    }
    
    func existsLogin() -> Bool {
        let local = LoginLocal()
        return local.existsLogin()
    }
}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}

