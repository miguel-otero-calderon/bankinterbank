//
//  InitViewControllerUseCase.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import Foundation
import UIKit

struct InitViewControllerUseCase {
    static func getInitViewController() -> UIViewController {
        let loginViewController = LoginWireFrame.createLoginModule()
        let postViewController = PostWireFrame.createPostModule() 
        let existsLogin = loginViewController.presenter?.existsLogin() ?? false
        if existsLogin {
           return postViewController
        } else {
            return loginViewController
        }
    }
}
