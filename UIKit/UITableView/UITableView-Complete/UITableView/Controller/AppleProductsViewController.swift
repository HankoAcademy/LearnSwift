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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        // Use the edit button provided by the view controller
        navigationItem.rightBarButtonItems = [
            editButtonItem,
            addButton
        ]
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)

        tableView.setEditing(editing, animated: true)
    }
    
    @objc func addButtonPressed() {
        let alertController = UIAlertController(
            title: "Add an Apple Product",
            message: "Select the type of product you'd like to add",
            preferredStyle: .actionSheet
        )
        
        alertController.addAction(
            UIAlertAction(
                title: SectionType.mac.title,
                style: .default
            ) { _ in
                self.presentAlert(for: .mac)
            }
        )
        
        alertController.addAction(
            UIAlertAction(
                title: SectionType.iphone.title,
                style: .default
            ) { _ in
                self.presentAlert(for: .iphone)
            }
        )
        
        alertController.addAction(
            UIAlertAction(
                title: SectionType.ipad.title,
                style: .default
            ) { _ in
                self.presentAlert(for: .ipad)
            }
        )
        
        present(alertController, animated: true)
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
    
    // MARK: - Alert Helper
    
    private func presentAlert(for section: SectionType) {
        let alertController = UIAlertController(title: "Enter product name and price", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Product Name"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Product Price"
        }
        
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            ) { alertAction in
                let name = alertController.textFields?[0].text
                let price = alertController.textFields?[1].text
                
                guard let name = name, let priceString = price, let price = Double(priceString) else { return }
                
                switch section {
                case .mac:
                    self.appleProducts.macs.append(Mac(withName: name, andPrice: price))
                    self.tableView.insertRows(at: [IndexPath(row: self.appleProducts.macs.count - 1, section: section.rawValue)], with: .automatic)
                case .iphone:
                    self.appleProducts.iPhones.append(IPhone(withName: name, andPrice: price))
                    self.tableView.insertRows(at: [IndexPath(row: self.appleProducts.iPhones.count - 1, section: section.rawValue)], with: .automatic)
                case .ipad:
                    self.appleProducts.iPads.append(IPad(withName: name, andPrice: price))
                    self.tableView.insertRows(at: [IndexPath(row: self.appleProducts.iPads.count - 1, section: section.rawValue)], with: .automatic)
                }
            }
        )
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        self.present(alertController, animated: true)
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
