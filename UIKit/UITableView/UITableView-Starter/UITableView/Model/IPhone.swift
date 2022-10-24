//
//  IPhone.swift
//  UITableView
//
//  Created by Han  on 9/11/21.
//

import Foundation

struct IPhone: Product {
    var name: String
    var price: Double
    
    init(withName name: String, andPrice price: Double) {
        self.name = name
        self.price = price
    }
}
