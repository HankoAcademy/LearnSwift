//
//  ContentView.swift
//  Optionals
//
//  Created by Hannie Kim on 9/10/21.
//

import UIKit

class ContentView: UIView {
    
    let buttonAction: (() -> Void)?
    
    let textFieldStackView: TextFieldStackView = {
        let stackView = TextFieldStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let labelStackView: LabelStackView = {
        let labelStackView = LabelStackView()
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelStackView
    }()
    
//    let stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .fillProportionally
//        return stackView
//    }()
//
//    let jobTitleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "iOS Engineer"
//        return label
//    }()
//
//    let linesOfCodeWrittenLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "1000"
//        return label
//    }()
//
//    let favoriteProgrammingLanguageLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Swift"
//        return label
//    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    init(buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        
        super.init(frame: .zero)
        
        backgroundColor = .lightGray
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
//        stackView.addArrangedSubview(jobTitleLabel)
//        stackView.addArrangedSubview(linesOfCodeWrittenLabel)
//        stackView.addArrangedSubview(favoriteProgrammingLanguageLabel)
        
        addSubview(textFieldStackView)
        
        addSubview(labelStackView)
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            textFieldStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
//            labelStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
//        NSLayoutConstraint.activate([
//            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
//            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
//            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
    }
    
    @objc func buttonPressed() {
        
        print("Button pressed")
        buttonAction?()
    }
}

class TextFieldStackView: UIStackView {
    
    let jobTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "What's your job title"
        textField.backgroundColor = .white
        return textField
    }()
    
    let linesOfCodeWrittenTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "How many lines of code have you written?"
        textField.backgroundColor = .white
        return textField
    }()
    
    let favoriteProgrammingLanguageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "What's your favorite programming language?"
        textField.backgroundColor = .white
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        alignment = .leading
        distribution = .fillEqually
        spacing = 10
        
        setUpViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
        addArrangedSubview(jobTitleTextField)
        addArrangedSubview(linesOfCodeWrittenTextField)
        addArrangedSubview(favoriteProgrammingLanguageTextField)
        
        NSLayoutConstraint.activate([
            jobTitleTextField.widthAnchor.constraint(equalTo: widthAnchor),
            jobTitleTextField.heightAnchor.constraint(equalToConstant: 75),

            linesOfCodeWrittenTextField.widthAnchor.constraint(equalTo: widthAnchor),
            linesOfCodeWrittenTextField.heightAnchor.constraint(equalToConstant: 75),
            
            favoriteProgrammingLanguageTextField.widthAnchor.constraint(equalTo: widthAnchor),
            favoriteProgrammingLanguageTextField.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
}

class LabelStackView: UIStackView {
    
    let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iOS Engineer"
        return label
    }()
    
    let linesOfCodeWrittenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1000"
        return label
    }()
    
    let favoriteProgrammingLanguageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Swift"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        alignment = .leading
        distribution = .fillProportionally
        spacing = 10
        
        setUpViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
        addArrangedSubview(jobTitleLabel)
        addArrangedSubview(linesOfCodeWrittenLabel)
        addArrangedSubview(favoriteProgrammingLanguageLabel)
        
//        NSLayoutConstraint.activate([
////            jobTitleLabel.widthAnchor.constraint(equalToConstant: <#T##CGFloat#>)
//            jobTitleLabel.widthAnchor.constraint(equalTo: widthAnchor),
//            linesOfCodeWrittenLabel.widthAnchor.constraint(equalTo: widthAnchor),
//            favoriteProgrammingLanguageLabel.widthAnchor.constraint(equalTo: widthAnchor)
//        ])
    }
}
