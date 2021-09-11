//
//  ViewController.swift
//  UITableView
//
//  Created by Hannie Kim on 9/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    var contentView: ContentView!
    var tableView: UITableView!
    
    override func loadView() {
        contentView = ContentView()
        view = contentView
        
        tableView = contentView.tableView
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell tapped")
    }
}

extension ViewController: UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "HI"
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hello"
        return cell
    }
}

class CustomTableViewHeader: UITableViewHeaderFooterView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
