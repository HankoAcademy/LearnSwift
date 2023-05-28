//
//  Common+Error.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 5/27/23.
//

import Foundation

enum CommonError: Error {
    case invalidURL
}

extension CommonError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("InvalidURL", comment: "Not a valid URL")
        }
    }
}
