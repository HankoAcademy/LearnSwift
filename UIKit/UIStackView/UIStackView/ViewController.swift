//
//  ViewController.swift
//  UIStackView
//
//  Created by Hannie Kim on 3/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    let blueView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    let helloWorldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, world"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    let labelOne: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label One"
        label.textColor = .systemPink
        return label
    }()
    
    let labelTwo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label Two"
        label.textColor = .green
        return label
    }()
    
    let labelThree: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label Three"
        label.textColor = .orange
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpUI()
    }
    
    func setUpUI() {
        
        setUpBlueLabelContainer()
        setUpSubmitButton()
        setUpLabels()
    }
    
    func setUpBlueLabelContainer() {
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blueView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        blueView.addSubview(helloWorldLabel)
        
        NSLayoutConstraint.activate([
            helloWorldLabel.centerXAnchor.constraint(equalTo: blueView.centerXAnchor),
            helloWorldLabel.centerYAnchor.constraint(equalTo: blueView.centerYAnchor),
        ])
    }
    
    func setUpSubmitButton() {
        
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/8)
        ])
    }
    
    func setUpLabels() {
        
        view.addSubview(labelOne)
        view.addSubview(labelTwo)
        view.addSubview(labelThree)
        
        labelOne.backgroundColor = .yellow
        labelTwo.backgroundColor = .yellow
        labelThree.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            labelOne.topAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 40),
            labelOne.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            labelOne.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            
            labelTwo.topAnchor.constraint(equalTo: labelOne.bottomAnchor, constant: 20),
            labelTwo.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            labelTwo.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            
            labelThree.topAnchor.constraint(equalTo: labelTwo.bottomAnchor, constant: 20),
            labelThree.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            labelThree.trailingAnchor.constraint(equalTo: blueView.trailingAnchor)
        ])
    }
}

