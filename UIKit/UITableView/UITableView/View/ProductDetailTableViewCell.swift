//
//  ProductDetailTableViewCell.swift
//  UITableView
//
//  Created by Han  on 9/11/21.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {
    
    // MARK: - UI Component Declarations
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
//        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    // MARK: - UI Configuration

    private func setupUI() {
        
        contentView.backgroundColor = UIColor(named: "Cream")
        
        stackView.addArrangedSubview(itemTitleLabel)
        stackView.addArrangedSubview(itemPriceLabel)
                                
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
        
        itemPriceLabel.setContentHuggingPriority(.required, for: .horizontal)
        itemPriceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func update(itemTitle: String, itemPrice: Double) {
        
        itemTitleLabel.text = itemTitle
        itemPriceLabel.text = String(format: "$%.02f", itemPrice)
    }
}
