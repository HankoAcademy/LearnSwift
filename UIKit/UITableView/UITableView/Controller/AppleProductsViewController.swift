//
//  AppleProductsViewController.swift
//  UITableView
//
//  Created by Hannie Kim on 9/10/21.
//

import UIKit

class AppleProductsViewController: UIViewController {
    
    // MARK: - Class Properties
    
    let appleProducts = AppleProducts()
    
    // MARK: - UI Properties
    
    var contentView: ContentView!
    var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        contentView = ContentView()
        view = contentView
        
        tableView = contentView.tableView
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate Methods

extension AppleProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell tapped")
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
}

// MARK: - UITableViewDataSource Methods

extension AppleProductsViewController: UITableViewDataSource {

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
