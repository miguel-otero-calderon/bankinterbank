//
//  PostEndpoint.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import Foundation
import Alamofire

enum PostEndpoint: EndPoint {
case getPost(String,Int)
    
    var apiKey: String {
        return ""
    }
    var baseURL: String {
        return "https://gorest.co.in"
    }
    var path: String {
        switch self {
        case .getPost(let title, let page):
            if title.isEmpty {
                return "/public/v1/posts"
            } else {
                if page <= 1 {
                    return "/public/v1/posts?title=\(title)"
                } else {
                    return "/public/v1/posts?title=\(title)&page=\(page)"
                }
            }
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
