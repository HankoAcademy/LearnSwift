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
    private var tableView: UITableView!
    
    // MARK: - UI Properties
    
    private var contentView: ContentView!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        contentView = ContentView()        
        view = contentView
        
        tableView = contentView.tableView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Macs"
        case 1:
            return "iPhones"
        case 2:
            return "iPads"
        default:
            return nil
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Testing"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
