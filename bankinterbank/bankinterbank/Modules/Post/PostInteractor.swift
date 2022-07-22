//
//  PostInteractor.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//  
//

import Foundation

protocol PostInteractorProtocol: AnyObject {
    var presenter: PostPresenterProtocol? { get set }
    func getPost(request: PostRequest?, completion: @escaping (PostResponse?, Error?) -> Void)
}

class PostInteractor {

    // MARK: Properties
    weak var presenter: PostPresenterProtocol?
}

extension PostInteractor: PostInteractorProtocol {
    func getPost(request: PostRequest?, completion: @escaping (PostResponse?, Error?) -> Void) {
        let service = PostService()
        service.getPost(request: request, completion: completion)
    }
}
