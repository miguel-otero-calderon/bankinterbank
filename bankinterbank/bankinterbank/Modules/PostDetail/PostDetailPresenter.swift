//
//  PostDetailPresenter.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation
import Alamofire

protocol PostDetailPresenterProtocol: AnyObject {
    var view: PostDetailViewControllerProtocol? { get set }
    var interactor: PostDetailInteractorProtocol? { get set }
    var wireFrame: PostDetailWireFrameProtocol? { get set }
    
    func getPost()
}

class PostDetailPresenter  {
    
    // MARK: Properties
    weak var view: PostDetailViewControllerProtocol?
    var interactor: PostDetailInteractorProtocol?
    var wireFrame: PostDetailWireFrameProtocol?
    
}

extension PostDetailPresenter: PostDetailPresenterProtocol {
    func getPost() {
        interactor?.getPost(completion: { response, error in
            if let error = error {
                self.view?.getPost(post:nil , error:error)
                return
            }
            if let response = response {
                self.view?.getPost(post: response, error: nil)
            }
        })
    }
}

