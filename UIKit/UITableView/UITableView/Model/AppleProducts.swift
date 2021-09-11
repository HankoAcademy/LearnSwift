//
//  AppleProducts.swift
//  UITableView
//
//  Created by Hannie Kim on 9/10/21.
//

import Foundation

protocol ProductDetail {
    var name: String { get set }
    var price: Double { get set }
    
    init(withName name: String, andPrice price: Double)
}

struct IPhone: ProductDetail {
    
    var name: String
    var price: Double
    
    init(withName name: String, andPrice price: Double) {
        self.name = name
        self.price = price
    }
}

struct IPad: ProductDetail {
    
    var name: String
    var price: Double
    
    init(withName name: String, andPrice price: Double) {
        self.name = name
        self.price = price
    }
    
}

struct Mac: ProductDetail {
    
    var name: String
    var price: Double
    
    init(withName name: String, andPrice price: Double) {
        self.name = name
        self.price = price
    }
}


struct AppleProducts {
    let macs = [
        Mac(withName: "Mac Pro", andPrice: 5999)
    ]
    
    let iPads = [
        IPad(withName: "iPad Pro 12.9\"", andPrice: 999)
    ]
    
    let iPhones = [
        IPhone(withName: "iPhone 12", andPrice: 999)
    ]
}
