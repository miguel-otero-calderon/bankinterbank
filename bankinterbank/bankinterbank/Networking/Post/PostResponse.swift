//
//  PostResponse.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import Foundation

struct PostResponse:Codable {
    
    let meta: Meta?
    let data: [Data]?
    
    struct Meta: Codable {
        struct Pagination:Codable {
            let total: Int?
            let pages: Int?
            let page: Int?
            let limit: Int?
        }
        struct links:Codable {
            let previous:String?
            let current:String?
            let next:String?
        }
    }
    struct Data:Codable {
        let id:Int?
        let userId:Int?
        let title:String?
        let body:String?
        
        func toModel() -> Post {
            return Post(id: id ?? .zero,
                        userId: userId ?? .zero,
                        title: title ?? "",
                        body: body ?? "")
        }
    }
}
