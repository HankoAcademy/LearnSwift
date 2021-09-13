//
//  HomeView.swift
//  Delegation
//
//  Created by Hannie Kim on 9/11/21.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - Class Properties
    
    // TODO: Replace closure with delegate
    var buttonAction: (() -> Void)
    
    // MARK: - UI Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "NavyColor")
        label.text = "Hanko's Food Truck"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(named: "NavyColor")
        label.text = "Serving the best tacos and sushi in town"
        return label
    }()
    
    let disclaimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        label.textColor = UIColor(named: "NavyColor")
        label.text = "Press Order Food to eat"
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "foodTruck")
        return imageView
    }()
    
    let orderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Order Food", for: .normal)
        button.backgroundColor = UIColor(named: "NavyColor")
        button.setTitleColor(UIColor(named: "CreamColor"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    init(buttonAction: @escaping () -> Void) {
        
        // TODO: Replace closure with delegate
        self.buttonAction = buttonAction
        
        super.init(frame: .zero)
                        
        backgroundColor = UIColor(named: "CreamColor")
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(imageView)
        addSubview(disclaimerLabel)
        addSubview(orderButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -10),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            disclaimerLabel.topAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: 8),
            disclaimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            disclaimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            disclaimerLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            orderButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            orderButton.bottomAnchor.constraint(equalTo: disclaimerLabel.topAnchor, constant: -8),
            orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            orderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    
    @objc func buttonPressed() {
        
        // TODO: Replace closure with delegate
        buttonAction()
    }
}
