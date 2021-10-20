//
//  ViewController.swift
//  ChildViewControllers
//
//  Created by Hannie Kim on 10/5/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Properties
    
    let topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        let topViewController = TopViewController()
        addChild(topViewController)
        topContainerView.addSubview(topViewController.view)
        topViewController.didMove(toParent: self)
        topViewController.view.frame = topContainerView.frame
        
        let bottomViewController = BottomViewController()
        addChild(bottomViewController)
        bottomContainerView.addSubview(bottomViewController.view)
        bottomViewController.didMove(toParent: self)
        bottomViewController.view.frame = bottomContainerView.frame
            
        // Uncomment to remove topViewController from container view
//        topViewController.willMove(toParent: nil)
//        topViewController.removeFromParent()
//        topViewController.view.removeFromSuperview()
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        view.backgroundColor = .white        
        view.addSubview(topContainerView)
        view.addSubview(bottomContainerView)
                
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            topContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
            bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 30),
            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
