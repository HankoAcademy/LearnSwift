//
//  BlogPostCommentsViewController.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 5/14/23.
//

import UIKit

class BlogPostCommentsViewController: UIViewController {
    
    private var blogPost: BlogPost
    private(set) var comments: [BlogPostComment]?
    private let networkManager: NetworkManager
    
    init(blogPost: BlogPost, networkManager: NetworkManager = NetworkManager()) {
        self.blogPost = blogPost
        self.networkManager = networkManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var blogPostTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TITLE: \(blogPost.title ?? "N/A")"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var blogPostBodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BODY: \(blogPost.body ?? "N/A")"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var editPostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit Post", for: .normal)
        button.backgroundColor = .systemYellow
        button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var deletePostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete Post", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Comments"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    
    @objc func editButtonPressed() {
        blogPost.title = "New Title"
        blogPost.body = "New Body"
        
        blogPostTitleLabel.text = blogPost.title
        blogPostBodyLabel.text = blogPost.body
        
        Task {
            do {
                // uncomment and comment line 90 to just make PATCH request
//                try await networkManager.editPost(blogPost)
                try await networkManager.replacePost(blogPost) // PUT request
            } catch {
                print("Editing blog failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func deleteButtonPressed() {
        Task {
            do {
                try await networkManager.deletePost(with: String(blogPost.id))
                navigationController?.popViewController(animated: true)
            } catch {
                print("Deleting blog failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        networkManager.postComments(forPostID: blogPost.id) { comments, error in
            if let error {
                print("Unable to request for post comments due to error: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.comments = comments
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(blogPostTitleLabel)
        view.addSubview(blogPostBodyLabel)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.addArrangedSubview(editPostButton)
        stackView.addArrangedSubview(deletePostButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            editPostButton.heightAnchor.constraint(equalToConstant: 50),
            editPostButton.widthAnchor.constraint(equalToConstant: 100),
            
            deletePostButton.heightAnchor.constraint(equalToConstant: 50),
            deletePostButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        view.addSubview(commentsLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            blogPostTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            blogPostTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            blogPostTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            blogPostBodyLabel.topAnchor.constraint(equalTo: blogPostTitleLabel.bottomAnchor, constant: 8),
            blogPostBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            blogPostBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: blogPostBodyLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            commentsLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            commentsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: commentsLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
}

extension BlogPostCommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = "From: \(comments?[indexPath.row].email ?? "N/A")"
        contentConfig.secondaryText = comments?[indexPath.row].body
        cell.contentConfiguration = contentConfig
        return cell
    }
}
