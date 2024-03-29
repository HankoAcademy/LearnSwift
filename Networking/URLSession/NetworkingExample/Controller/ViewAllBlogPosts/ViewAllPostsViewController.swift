//
//  ViewAllBlogPostsViewController.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 5/14/23.
//

import UIKit

final class ViewAllBlogPostsViewController: UIViewController {

    // MARK: - Properties
    
    private let networkManager: NetworkManager
    var blogPosts: [BlogPost]?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hanko Academy Blog"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Initializer
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
//        allPostsUsingCompletionHandler()
        allPostsUsingResultType()

//        Task {
//            await fetchAllPosts()
//        }
    }
    
    private func allPostsUsingCompletionHandler() {
        networkManager.allPosts { blogPosts, error in
            if let error {
                // Add error handling. Maybe an alert.
                print("Unable to retrieve posts due to error: \(error.localizedDescription)")
                return
            }

            DispatchQueue.main.async {
                self.blogPosts = blogPosts
                self.tableView.reloadData()
            }
        }
    }
    
    private func allPostsUsingResultType() {
        networkManager.allPosts { result in
            switch result {
            case .success(let blogPosts):
                DispatchQueue.main.async {
                    self.blogPosts = blogPosts
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchAllPosts() async {
        do {
            self.blogPosts = try await networkManager.allPost()
            await MainActor.run {
                self.tableView.reloadData()
            }
            
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        } catch let error as NetworkManager.APIError {
            print("Failed for generic API Error: \(error)")
        } catch CommonError.invalidURL {
            print("Failed for invalid URL error")
        } catch {
            print("Unknown error")
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createBlogPost))
        navigationItem.rightBarButtonItem = addBarButton
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    // MARK: - Action
    
    @objc private func createBlogPost() {
        let id = Int.random(in: 1...1000)
        let userId = 20
        let blogPost = BlogPost(id: id, userId: userId, title: "Networking in Swift", body: "Here's an article about how to hook up an API with your iOS app.")
        Task {
            do {
                try await networkManager.createPost(blogPost)
                blogPosts?.append(blogPost)
                tableView.reloadData()
            } catch {
                print("Failed to create blog post")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewAllBlogPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = blogPosts?[indexPath.row].title
        contentConfig.secondaryText = blogPosts?[indexPath.row].body
        cell.contentConfiguration = contentConfig
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewAllBlogPostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let blogPostID = blogPosts?[indexPath.row].id else { return }
        
        networkManager.post(withID: blogPostID) { [weak self] blogPost, error in
            if let error {
                print("Unable to fetch a blog post due to error: \(error.localizedDescription)")
                return
            }
            
            if let blogPost {
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(BlogPostCommentsViewController(blogPost: blogPost), animated: true)
                }
            }
        }
    }
}
