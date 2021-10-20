//
//  ViewController.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 10/3/21.
//

import UIKit

class ViewController: BaseViewController {

    // MARK: - Properties
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.text = "User"
        return label
    }()
    
    let fetchUsersButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.setTitle("Fetch a Random User", for: .normal)
        button.addTarget(self, action: #selector(fetchUserButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    // MARK: - UI Setup

    private func setUpUI() {
        
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(fetchUsersButton)
        view.addSubview(stackView)
                
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fetchUsersButton.heightAnchor.constraint(equalToConstant: 50),
            fetchUsersButton.widthAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    // MARK: - Actions
    
    @objc func fetchUserButtonPressed() {
        fetchUser { users, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.usernameLabel.text = users?.randomElement()?.username
                self?.removeSpinner()
            }
        }
    }
    
    // MARK: - Networking
    
    private func fetchUser(completion: @escaping ([User]?, Error?) -> Void) {
        guard let usersURL = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: usersURL)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        addSpinner()
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(users, error)
                print(users)
            }
            catch {
                print("Failed to convert \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()
    }
}
