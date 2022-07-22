//
//  PostDetailWireFrame.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation
import UIKit

protocol PostDetailWireFrameProtocol: AnyObject {
    static func createPostModule(post:Post) -> PostDetailViewControllerProtocol
}

class PostDetailWireFrame: PostDetailWireFrameProtocol {

    class func createPostModule(post:Post) -> PostDetailViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "PostDetail", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
        let presenter: PostDetailPresenterProtocol = PostDetailPresenter()
        let interactor: PostDetailInteractorProtocol = PostDetailInteractor()
        let wireFrame :PostDetailWireFrameProtocol = PostDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.setPost(post:post)
        return view
    }
    
}
