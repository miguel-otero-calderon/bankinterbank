//
//  PostWireFrame.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import Foundation
import UIKit

protocol PostWireFrameProtocol: AnyObject {
    static func createPostModule() -> PostViewController
}

class PostWireFrame: PostWireFrameProtocol {

    class func createPostModule() -> PostViewController {
        
        let storyboard = UIStoryboard(name: "Post", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        let presenter: PostPresenterProtocol = PostPresenter()
        let interactor: PostInteractorProtocol = PostInteractor()
        let wireFrame :PostWireFrameProtocol = PostWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
}
