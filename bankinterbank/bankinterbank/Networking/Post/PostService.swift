//
//  PostService.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import Foundation
import Alamofire

protocol PostServiceProtocol {
    func getPost(request:PostRequest?, completion: @escaping (PostResponse?, Error?) -> Void )
}

class PostService: PostServiceProtocol {
    func getPost(request:PostRequest?, completion: @escaping (PostResponse?, Error?) -> Void) {
        let endpoint:PostEndpoint = .getPost(request?.title ?? "", request?.page ?? 1)
        
        print(endpoint.toURL())
        
        AF.request(endpoint.toURL(),method: endpoint.method,headers: endpoint.headers)
            .response{[weak self] response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode(PostResponse.self, from: data)
                        completion(response, nil)
                    } catch(let error) {
                        completion(nil,error)
                        print(error)
                    }
                case .failure(let error):
                    completion(nil,error)
                }
            }
    }
}
