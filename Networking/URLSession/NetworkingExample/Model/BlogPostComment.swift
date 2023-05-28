//
//  BlogPostComment.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 5/27/23.
//

import Foundation

struct BlogPostComment: Codable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
