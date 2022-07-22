//
//  PostEndpoint.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import Foundation
import Alamofire

enum PostEndpoint: EndPoint {
    case getPost
    
    var apiKey: String {
        return ""
    }
    var baseURL: String {
        return "https://gorest.co.in"
    }
    var path: String {
        switch self {
        case .getPost:
            return "/public/v1/posts"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getPost:
            return .get
        }
    }
    var encoding: ParameterEncoding {
        switch self {
        case .getPost:
            return URLEncoding.default
        }
    }
    var headers: HTTPHeaders? {
        return []
    }
}
