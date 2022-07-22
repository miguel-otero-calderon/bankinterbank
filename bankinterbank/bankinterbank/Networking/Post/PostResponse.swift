//
//  PostResponse.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import Foundation

struct PostResponse:Codable {    
    let meta: PostResponseMeta?
    let data: [PostResponseData]?
}
struct PostResponseMeta: Codable {
    let pagination:PostResponsePagination?
    let links:PostResponseLinks?
}
struct PostResponsePagination:Codable {
    let total: Int?
    let pages: Int?
    let page: Int?
    let limit: Int?
    
    func toModel() -> Pagination {
        return Pagination(total: total ?? .zero,
                          pages: pages ?? .zero,
                          page: page ?? .zero,
                          limit: limit ?? .zero)
    }
}
struct PostResponseLinks:Codable {
    let previous:String?
    let current:String?
    let next:String?
    
    func toModel() -> Links {
        return Links(previous: previous ?? "",
                     current: current ?? "",
                     next: next ?? "")
    }
}
struct PostResponseData:Codable {
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
