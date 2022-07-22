//
//  PostProtocols.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//  
//

import Foundation
import UIKit

protocol PostViewControllerProtocol: class {
    // PRESENTER -> VIEW
    var presenter: PostPresenterProtocol? { get set }
}

protocol PostWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createPostModule() -> PostViewControllerProtocol
}

protocol PostPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: PostViewControllerProtocol? { get set }
    var interactor: PostInteractorInputProtocol? { get set }
    var wireFrame: PostWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol PostInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol PostInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: PostInteractorOutputProtocol? { get set }
    var localDatamanager: PostLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: PostRemoteDataManagerInputProtocol? { get set }
}

protocol PostDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol PostRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: PostRemoteDataManagerOutputProtocol? { get set }
}

protocol PostRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol PostLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
