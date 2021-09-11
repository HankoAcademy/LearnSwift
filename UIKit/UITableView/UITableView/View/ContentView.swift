//
//  ContentView.swift
//  UITableView
//
//  Created by Hannie Kim on 9/10/21.
//

import UIKit

class ContentView: UIView {

    // MARK: - UI Properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "Cream")
        tableView.layer.cornerRadius = 20
        tableView.allowsSelection = false
        tableView.register(ProductDetailTableViewCell.self, forCellReuseIdentifier: "ProductDetailTableViewCell")
        tableView.register(ProductTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProductTableHeaderView")
        return tableView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
