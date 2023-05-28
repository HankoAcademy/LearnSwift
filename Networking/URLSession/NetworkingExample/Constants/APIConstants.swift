//
//  APIConstants.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 5/27/23.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    struct Path {
        static let posts = "/posts"
        static let comments = "/comments"
    }
    
    struct URL {
        static let allPosts = baseURL + Path.posts
        
        static func post(withID id: String) -> String {
            return "\(allPosts)/\(id)"
        }
        
        static func postComments(forPostID postID: String) -> String {
            return "\(post(withID: postID))\(Path.comments)"
        }
    }
}
