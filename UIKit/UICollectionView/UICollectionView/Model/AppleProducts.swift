//
//  AppleProducts.swift
//  UITableView
//
//  Created by Hannie Kim on 9/10/21.
//

import Foundation

protocol ProductDetail {
    var name: String { get }
    var price: Double { get }
    
    init(withName name: String, andPrice price: Double)
}

enum ProductType: Int, CaseIterable {
    case macs
    case iphone
    case ipad
}

struct AppleProducts {
    var macs = [
        Mac(withName: "iMac", andPrice: 1299),
        Mac(withName: "Mac Mini", andPrice: 699),
        Mac(withName: "Mac Pro", andPrice: 5999),
        Mac(withName: "Macbook Pro", andPrice: 1299),
        Mac(withName: "Macbook Air", andPrice: 999)
    ]
    
    var iPhones = [
        IPhone(withName: "iPhone 12", andPrice: 799),
        IPhone(withName: "iPhone 12 Mini", andPrice: 699),
        IPhone(withName: "iPhone 12 Pro", andPrice: 999),
        IPhone(withName: "iPhone 12 Pro Max", andPrice: 1099)
    ]
        
    var iPads = [
        IPad(withName: "iPad", andPrice: 329),
        IPad(withName: "iPad Pro", andPrice: 799),
        IPad(withName: "iPad Air", andPrice: 599),
        IPad(withName: "iPad Mini", andPrice: 399)
    ]        
}
