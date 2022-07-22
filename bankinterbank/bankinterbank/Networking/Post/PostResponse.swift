//
//  PostResponse.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import Foundation

struct PostResponse:Codable {
    
    let meta: Meta?
    let data: [Post]?
    
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
    struct Post:Codable {
        let id:Int?
        let userId:Int?
        let title:String?
        let body:String?
    }
}
