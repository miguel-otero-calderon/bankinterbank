//
//  LoginWireFrame.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation
import UIKit

protocol LoginWireFrameProtocol: AnyObject {
    static func createLoginModule() -> LoginViewController
}

class LoginWireFrame: LoginWireFrameProtocol {

    class func createLoginModule() -> LoginViewController {
        
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let presenter: LoginPresenterProtocol = LoginPresenter()
        let interactor: LoginInteractorProtocol = LoginInteractor()
        let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
