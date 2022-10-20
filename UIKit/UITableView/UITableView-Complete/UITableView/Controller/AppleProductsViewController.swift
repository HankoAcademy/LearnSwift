//
//  AppleProductsViewController.swift
//  UITableView
//
//  Created by Hannie Kim on 9/10/21.
//

import UIKit

class AppleProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    enum SectionType: Int, CaseIterable {
        case mac, iphone, ipad
        
        var title: String {
            switch self {
            case .mac:
                return "Macs"
            case .iphone:
                return "iPhones"
            case .ipad:
                return "iPads"
            }
        }
    }
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(ProductDetailTableViewCell.self, forCellReuseIdentifier: ProductDetailTableViewCell.cellID)
        tableView.register(ProductTableHeaderView.self, forHeaderFooterViewReuseIdentifier: ProductTableHeaderView.cellID)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let appleProducts: AppleProducts
    
    // MARK: - Initializer
    
    init(appleProducts: AppleProducts = AppleProducts()) {
        self.appleProducts = appleProducts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Cream")
        setUpTableView()
    }
    
    // MARK: - UI Setup
    
    private func setUpTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SectionType(rawValue: indexPath.section) {
        case .mac:
            let mac = appleProducts.macs[indexPath.row]
            print("Selected a \(mac.name) that costs \(mac.price)")
        case .iphone:
            let iPhone = appleProducts.iPhones[indexPath.row]
            print("Selected a \(iPhone.name) that costs \(iPhone.price)")
        case .ipad:
            let iPad = appleProducts.iPads[indexPath.row]
            print("Selected a \(iPad.name) that costs \(iPad.price)")
        case .none:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProductTableHeaderView") as? ProductTableHeaderView,
            let sectionType = SectionType(rawValue: section)
        else {
            return nil
        }
        
        headerView.configure(headerTitle: sectionType.title)
        
        return headerView
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SectionType(rawValue: section) {
        case .mac:
            return appleProducts.macs.count
        case .iphone:
            return appleProducts.iPhones.count
        case .ipad:
            return appleProducts.iPads.count
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.cellID, for: indexPath) as? ProductDetailTableViewCell else {
            return UITableViewCell()
        }
        
        var product: ProductDetail?
        
        switch SectionType(rawValue: indexPath.section) {
        case .mac:
            product = appleProducts.macs[indexPath.row]
        case .iphone:
            product = appleProducts.iPhones[indexPath.row]
        case .ipad:
            product = appleProducts.iPads[indexPath.row]
        case .none:
            return UITableViewCell()
        }
        
        if let product = product {
            cell.configure(itemTitle: product.name, itemPrice: product.price)
        }
        
        return cell
    }
}
