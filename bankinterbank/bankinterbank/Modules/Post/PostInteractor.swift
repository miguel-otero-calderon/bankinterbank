//
//  PostInteractor.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//  
//

import Foundation

class PostInteractor: PostInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: PostInteractorOutputProtocol?
    var localDatamanager: PostLocalDataManagerInputProtocol?
    var remoteDatamanager: PostRemoteDataManagerInputProtocol?

}

extension PostInteractor: PostRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
