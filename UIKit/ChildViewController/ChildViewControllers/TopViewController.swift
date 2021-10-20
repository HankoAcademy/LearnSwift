//
//  TopViewController.swift
//  ChildViewControllers
//
//  Created by Hannie Kim on 10/5/21.
//

import UIKit

class TopViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Child View Controller"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .systemPink
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
