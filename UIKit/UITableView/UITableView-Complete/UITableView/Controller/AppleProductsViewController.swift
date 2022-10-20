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
    
    private var appleProducts: AppleProducts
    
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
        
        // Use the edit button provided by the view controller
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)

        tableView.setEditing(editing, animated: true)
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 1. Delete the data from data source i.e. appleProducts array
            switch SectionType(rawValue: indexPath.section) {
            case .mac:
                appleProducts.macs.remove(at: indexPath.row)
            case .iphone:
                appleProducts.iPhones.remove(at: indexPath.row)
            case .ipad:
                appleProducts.iPads.remove(at: indexPath.row)
            case .none:
                return
            }
            
            // 2. Delete the row
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
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
        
        var product: Product?
        
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
    
    // Allows moving of cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var movingProduct: Product?
        
        // 1. Find the product object that is moving

        switch SectionType(rawValue: sourceIndexPath.section) {
        case .mac:
            movingProduct = appleProducts.macs[sourceIndexPath.row]
        case .iphone:
            movingProduct = appleProducts.iPhones[sourceIndexPath.row]
        case .ipad:
            movingProduct = appleProducts.iPads[sourceIndexPath.row]
        case .none:
            break
        }
        
        guard let movingProduct = movingProduct else { return }
        
        // 2. Add the object to the destination product array
        switch SectionType(rawValue: destinationIndexPath.section) {
        case .mac:
            appleProducts.macs.insert(movingProduct, at: destinationIndexPath.row)
        case .iphone:
            appleProducts.iPhones.insert(movingProduct, at: destinationIndexPath.row)
        case .ipad:
            appleProducts.iPads.insert(movingProduct, at: destinationIndexPath.row)
        case .none:
            break
        }
        
        // 3. Delete the row that the product was moved from
        switch SectionType(rawValue: sourceIndexPath.section) {
        case .mac:
            appleProducts.macs.remove(at: sourceIndexPath.row)
        case .iphone:
            appleProducts.iPhones.remove(at: sourceIndexPath.row)
        case .ipad:
            appleProducts.iPads.remove(at: sourceIndexPath.row)
        case .none:
            break
        }
    }
}
