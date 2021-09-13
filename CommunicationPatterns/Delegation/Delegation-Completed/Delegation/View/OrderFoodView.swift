//
//  OrderFoodView.swift
//  Delegation
//
//  Created by Hannie Kim on 9/11/21.
//

import UIKit

class OrderFoodView: UIView {
    
    // MARK: - Class Properties
    
    weak var foodOrderingDelegate: FoodOrdering?
    
    let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "NavyColor")
        label.text = "Tacos or Sushi?"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(named: "NavyColor")
        label.text = "Tap on one!"
        return label
    }()
    
    let tacoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "taco"), for: .normal)
        button.addTarget(self, action: #selector(tacoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let sushiButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "sushi"), for: .normal)
        button.addTarget(self, action: #selector(sushiButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    init(foodOrderingDelegate: FoodOrdering?) {
        
        self.foodOrderingDelegate = foodOrderingDelegate
        
        super.init(frame: .zero)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        
        backgroundColor = UIColor(named: "CreamColor")
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        imageStackView.addArrangedSubview(tacoButton)
        imageStackView.addArrangedSubview(sushiButton)
        
        addSubview(imageStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            tacoButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/4),
            tacoButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 1/2),
            
            sushiButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/4),
            sushiButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 1/2),
            
            imageStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc func tacoButtonPressed() {
        
        foodOrderingDelegate?.order(food: "Tacos")
    }
    
    @objc func sushiButtonPressed() {
        
        foodOrderingDelegate?.order(food: "Sushi")
    }
}
