//
//  PostPresenter.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//  
//

import Foundation
import Alamofire

protocol PostPresenterProtocol: AnyObject {
    var view: PostViewControllerProtocol? { get set }
    var interactor: PostInteractorProtocol? { get set }
    var wireFrame: PostWireFrameProtocol? { get set }
    
    func getPost(request: PostRequest?)
}

class PostPresenter  {
    
    // MARK: Properties
    weak var view: PostViewControllerProtocol?
    var interactor: PostInteractorProtocol?
    var wireFrame: PostWireFrameProtocol?
    
}

extension PostPresenter: PostPresenterProtocol {
    
    func getPost(request: PostRequest?) {
        interactor?.getPost(request: request, completion: { response, error in
            if let error = error {
                self.view?.getPost(meta: nil, posts: nil, error: error)
                return
            }
            if let response = response {
                if let data = response.data,
                    let pagination = response.meta?.pagination {
                    
                    var posts:[Post] = []
                    for item in data {
                        posts.append(item.toModel())
                    }
                    
                    let links = response.meta?.links ?? PostResponseLinks(previous: "", current: "", next: "")
                    
                    let meta = Meta(pagination: pagination.toModel(),
                                    links: links.toModel())
                    
                    self.view?.getPost(meta:meta , posts: posts, error: nil)
                }
            }
        })
    }
}
