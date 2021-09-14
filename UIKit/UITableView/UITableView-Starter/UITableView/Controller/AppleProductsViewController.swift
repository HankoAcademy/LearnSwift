//
//  AppleProductsViewController.swift
//  UITableView
//
//  Created by Hannie Kim on 9/10/21.
//

import UIKit

class AppleProductsViewController: UIViewController {
    
    // MARK: - Class Properties
    
    private let appleProducts = AppleProducts()
    
    // MARK: - UI Properties
    
    private var contentView: ContentView!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        contentView = ContentView()
        
        view = contentView
    }
}
