//
//  LoginPresenter.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getTermsOfService() -> String
    func getPrivacyPolicy() -> String
    func signIn(email: String,password: String,completion: @escaping (Result<Login, Error>) -> Void)
    func existsLogin() -> Bool
}

class LoginPresenter  {
    
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var wireFrame: LoginWireFrameProtocol?
    
}

extension LoginPresenter: LoginPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func getTermsOfService() -> String {
        return "https://www.instagram.com/"
    }
    
    func getPrivacyPolicy() -> String {
        return "https://www.instagram.com/"
    }

    func signIn(email: String, password: String, completion: @escaping (Result<Login, Error>) -> Void) {
        interactor?.signIn(email: email, password: password, completion: completion)
    }
    
    func existsLogin() -> Bool {
        return interactor?.existsLogin() ?? false
    }
}
