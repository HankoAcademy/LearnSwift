//
//  AppleProductsViewController.swift
//  UITableView
//
//  Created by Hannie Kim on 9/10/21.
//

import UIKit

class AppleProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Class Properties
    
    private let appleProducts = AppleProducts()
    
    // MARK: - UI Properties
    
    private var contentView: ContentView!
    private var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        contentView = ContentView()
        view = contentView
        
        tableView = contentView.tableView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let mac = appleProducts.macs[indexPath.row]
            print("Selected a \(mac.name) that costs \(mac.price)")
        case 1:
            let iPhone = appleProducts.iPhones[indexPath.row]
            print("Selected a \(iPhone.name) that costs \(iPhone.price)")
        case 2:
            let iPad = appleProducts.iPads[indexPath.row]
            print("Selected a \(iPad.name) that costs \(iPad.price)")
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProductTableHeaderView") as? ProductTableHeaderView else {
            return nil
        }
        
        switch section {
        case 0:
            cell.headerTitle = "Macs"
        case 1:
            cell.headerTitle = "iPhones"
        case 2:
            cell.headerTitle = "iPads"
        default:
            return nil
        }
        
        
        return cell
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return appleProducts.macs.count
        case 1:
            return appleProducts.iPhones.count
        case 2:
            return appleProducts.iPads.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell", for: indexPath) as? ProductDetailTableViewCell else {
            return UITableViewCell()
        }
        
        var product: ProductDetail?
        
        switch indexPath.section {
        case 0:
            product = appleProducts.macs[indexPath.row]
        case 1:
            product = appleProducts.iPhones[indexPath.row]
        case 2:
            product = appleProducts.iPads[indexPath.row]
        default:
            return UITableViewCell()
        }
        
        if let product = product {
            cell.update(itemTitle: product.name, itemPrice: product.price)
        }
        
        return cell
    }
}
