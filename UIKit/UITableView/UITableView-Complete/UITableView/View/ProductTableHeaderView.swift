//
//  ProductTableHeaderView.swift
//  UITableView
//
//  Created by Hannie Kim on 9/14/21.
//

import UIKit

class ProductTableHeaderView: UITableViewHeaderFooterView {

    // MARK: - Properties
    
    static let cellID = "ProductTableHeaderView"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Navy")
        return view
    }()
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(bottomLineView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            headerLabel.bottomAnchor.constraint(equalTo: bottomLineView.topAnchor, constant: -16),
            
            bottomLineView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            bottomLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(headerTitle: String) {
        let attributedString = NSMutableAttributedString(string: headerTitle)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 14, range: NSRange(location: 0, length: attributedString.length))
        headerLabel.attributedText = attributedString
    }
}
