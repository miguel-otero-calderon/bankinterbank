//
//  PostDetailInteractor.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation

protocol PostDetailInteractorProtocol: AnyObject {
    var presenter: PostDetailPresenterProtocol? { get set }
    func setPost(post:Post)
    func getPost(completion: @escaping (Post?, Error?) -> ())
}

class PostDetailInteractor {
    
    // MARK: Properties
    weak var presenter: PostDetailPresenterProtocol?
    var post:Post?
}

extension PostDetailInteractor: PostDetailInteractorProtocol {
    func setPost(post:Post) {
        //guardar con core data
        self.post = post
    }
    func getPost(completion: @escaping (Post?, Error?) -> ()) {
        //recuperar con coredata
        completion(post, nil)
    }
}
