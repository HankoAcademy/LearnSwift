//
//  NetworkManager.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 5/14/23.
//

import Foundation

extension NetworkManager.APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .genericError:
            return NSLocalizedString("Unknown API error", comment: "Generic API Error")
        }
    }
}

enum CommonError: Error {
    case invalidURL
}

final class NetworkManager {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    enum APIError: Error {
        case genericError
    }
    
    // MARK: - Completion Handler
    
    func allPosts(completion: @escaping ([BlogPost]?, Error?) -> Void) {
        guard let allPostsURL = URL(string: APIConstants.URL.allPosts) else {
            completion(nil, CommonError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: allPostsURL)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, APIError.genericError)
                return
            }
            
            do {
                let blogPosts = try JSONDecoder().decode([BlogPost].self, from: data)
                completion(blogPosts, nil)
            } catch {
                print("Failed to decode BlogPosts with error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    // MARK: - Result Type
    
    func allPosts(completion: @escaping (Result<[BlogPost], Error>) -> Void) {
        guard let allPostsURL = URL(string: APIConstants.URL.allPosts) else {
            completion(.failure(CommonError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: allPostsURL)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.genericError))
                return
            }
            
            do {
                let blogPosts = try JSONDecoder().decode([BlogPost].self, from: data)
                completion(.success(blogPosts))
            } catch {
                print("Failed to decode BlogPosts with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Async Await
    
    func allPost() async throws -> [BlogPost] {
        guard let allPostsURL = URL(string: APIConstants.URL.allPosts) else {
            throw CommonError.invalidURL
        }
        
        var urlRequest = URLRequest(url: allPostsURL)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let blogPosts = try JSONDecoder().decode([BlogPost].self, from: data)
            return blogPosts
        } catch {
            print("Failed to decode BlogPosts with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func postComments(forPostID postID: Int, completion: @escaping ([BlogPostComment]?, Error?) -> Void) {
        guard let postCommentsURL = URL(string: APIConstants.URL.postComments(forPostID: String(postID))) else {
            completion(nil, CommonError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: postCommentsURL)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, APIError.genericError)
                return
            }
            
            do {
                let blogPost = try JSONDecoder().decode([BlogPostComment].self, from: data)
                completion(blogPost, nil)
            } catch {
                print("Failed to decode array of `BlogPostComment` with error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func post(withID id: Int, completion: @escaping (BlogPost?, Error?) -> Void) {
        guard let postWithIDURL = URL(string: APIConstants.URL.post(withID: String(id))) else {
            completion(nil, CommonError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: postWithIDURL)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, APIError.genericError)
                return
            }
            
            do {
                let blogPost = try JSONDecoder().decode(BlogPost.self, from: data)
                completion(blogPost, nil)
            } catch {
                print("Failed to decode a BlogPost with error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    // MARK: - POST Request
    
    func createPost(_ blogPost: BlogPost) async throws {
        guard let postsURL = URL(string: APIConstants.URL.allPosts) else {
            throw CommonError.invalidURL
        }
        
        var urlRequest = URLRequest(url: postsURL)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(blogPost)
        urlRequest.httpBody = jsonData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.genericError
            }
            
            let createdBlogPost = try JSONDecoder().decode(BlogPost.self, from: data)
            print("New post: \(createdBlogPost)")
        } catch {
            print("Failed to decode BlogPosts with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    // MARK: - PUT Request
    
    func editPost(_ blogPost: BlogPost) async throws {
        guard let postWithIDURL = URL(string: APIConstants.URL.post(withID: String(blogPost.id))) else {
            throw CommonError.invalidURL
        }
        
        var urlRequest = URLRequest(url: postWithIDURL)
        urlRequest.httpMethod = HTTPMethod.patch.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(blogPost)
        urlRequest.httpBody = jsonData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.genericError
            }
            
            let editedPost = try JSONDecoder().decode(BlogPost.self, from: data)
            print("PATCH Edited post: \(editedPost)")
        } catch {
            throw error
        }
    }
    
    // MARK: - PATCH
    
    func replacePost(_ blogPost: BlogPost) async throws {
        guard let postWithIDURL = URL(string: APIConstants.URL.post(withID: String(blogPost.id))) else {
            throw CommonError.invalidURL
        }
        
        var urlRequest = URLRequest(url: postWithIDURL)
        urlRequest.httpMethod = HTTPMethod.put.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(blogPost)
        urlRequest.httpBody = jsonData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.genericError
            }
            
            let editedPost = try JSONDecoder().decode(BlogPost.self, from: data)
            print("PUT blog post: \(editedPost)")
        } catch {
            throw error
        }
    }
    
    // MARK: - Delete
    
    func deletePost(with id: String) async throws {
        guard let postWithIDURL = URL(string: APIConstants.URL.post(withID: id)) else {
            throw CommonError.invalidURL
        }
        
        var urlRequest = URLRequest(url: postWithIDURL)
        urlRequest.httpMethod = HTTPMethod.delete.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let _ = try await URLSession.shared.data(for: urlRequest)
    }
}
