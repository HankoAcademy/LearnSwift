//
//  ViewController.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 5/23/21.
//

import UIKit

class ViewController: UIViewController {

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
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(fetchUsersButton)
        
        NSLayoutConstraint.activate([
            fetchUsersButton.heightAnchor.constraint(equalToConstant: 50),
            fetchUsersButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func fetchUserButtonPressed() {
        
        guard let usersURL = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Invalid URL")
            return
        }

        // Prepare URL Request object
        var request = URLRequest(url: usersURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: Any] = [
            "name": "Han Kim",
            "username": "hanlovespourovers",
            "email": "han@test.com",
            "phone": "555-5555"
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData

        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }

            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {

                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
                
        // Fetch a random user

        fetchUser { users, error in

            if let error = error {
                print("Error: \(error.localizedDescription)")
            }

            DispatchQueue.main.async { [weak self] in

                self?.usernameLabel.text = users?.randomElement()?.username
            }
        }
    }
    
    private func fetchUser(completion: @escaping ([User]?, Error?) -> Void) {
        
        // The URL where we'll be making our network request to
        guard let usersURL = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Invalid URL")
            return
        }
        
        // URLRequest uses a non-optional URL to construct the URLRequest
        var urlRequest = URLRequest(url: usersURL)
        urlRequest.httpMethod = "GET"
        
        // Start a networking task using the URLRequest we made
        // Most common to use the `shared` session that iOS lets us use, rather than making our own session.
            // If `shared` session doesn't fit your needs, look into creating a custom session
        
        let fetchUsersTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            response
            // Everything in this closure waits to get called until the dataTask is complete, whether or not the request was successful.
            
            // This is still technically on the background thread, since URLSession automatically runs in the background.
            // For any UI changes done in this closure, it must be done on the `main` thread
            
            // All 3 of the closure parameters are optionals.
            
            // If the response returns an error, no data is returned.
            // If the response returns data, then no error is returned.
            
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                // We use data to decode
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(users, error)
            }
            catch {
                print("Failed to convert \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        fetchUsersTask.resume() // Don't forget this. Without resume(), your dataTask won't do anything.
        // But with it the request starts immediately, and control gets handed over to the system – it will automatically run in the background, and won’t be destroyed even after our method ends.
    }
    
    private func postUser(completion: @escaping ([User]?, Error?) -> Void) {
        
        
    }
}

struct User: Codable {
    let name: String
    let username: String
    let email: String
}
