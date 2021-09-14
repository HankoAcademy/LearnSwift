//
//  ProductTableHeaderView.swift
//  UITableView
//
//  Created by Han on 9/10/21.
//

import UIKit

class ProductTableHeaderView: UITableViewHeaderFooterView {

    // MARK: - Class Properties
    
    var headerTitle: String = "" {
        didSet {
            let attributedString = NSMutableAttributedString(string: headerTitle)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: 14, range: NSRange(location: 0, length: attributedString.length))
            headerLabel.attributedText = attributedString
        }
    }
    
    // MARK: - UI Properties
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let bottomLineView: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(named: "Navy")
        return line
    }()
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        
        contentView.backgroundColor = UIColor(named: "Cream")
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(bottomLineView)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            headerLabel.bottomAnchor.constraint(equalTo: bottomLineView.topAnchor, constant: -16),
            
            bottomLineView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1),
            bottomLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
