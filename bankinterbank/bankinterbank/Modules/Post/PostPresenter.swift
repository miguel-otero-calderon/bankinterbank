//
//  PostPresenter.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//  
//

import Foundation

class PostPresenter  {
    
    // MARK: Properties
    weak var view: PostViewControllerProtocol?
    var interactor: PostInteractorInputProtocol?
    var wireFrame: PostWireFrameProtocol?
    
}

extension PostPresenter: PostPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension PostPresenter: PostInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
