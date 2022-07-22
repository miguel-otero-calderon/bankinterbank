//
//  PostWireFrame.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//  
//

import Foundation
import UIKit

class PostWireFrame: PostWireFrameProtocol {

    class func createPostModule() -> PostViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "Post", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        let presenter: PostPresenterProtocol & PostInteractorOutputProtocol = PostPresenter()
        let interactor: PostInteractorInputProtocol & PostRemoteDataManagerOutputProtocol = PostInteractor()
        let localDataManager: PostLocalDataManagerInputProtocol = PostLocalDataManager()
        let remoteDataManager: PostRemoteDataManagerInputProtocol = PostRemoteDataManager()
        let wireFrame: PostWireFrameProtocol = PostWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
}
