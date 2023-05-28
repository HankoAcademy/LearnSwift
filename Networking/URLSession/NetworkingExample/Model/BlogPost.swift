//
//  BlogPost.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 5/27/23.
//

import Foundation

struct BlogPost: Codable {
    let id: Int
    let userId: Int
    var title: String?
    var body: String?
}
