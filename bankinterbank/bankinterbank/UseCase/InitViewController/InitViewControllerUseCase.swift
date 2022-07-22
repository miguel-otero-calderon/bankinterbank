//
//  InitViewControllerUseCase.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import Foundation
import UIKit

struct InitViewControllerUseCase {
    static func getInitViewController() -> UIViewController {
        return PostWireFrame.createPostModule() as! UIViewController
    }
}
