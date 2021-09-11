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

struct AppleProducts {
    let macs = [
        Mac(withName: "iMac", andPrice: 5999),
        Mac(withName: "Mac Mini", andPrice: 5999),
        Mac(withName: "Mac Pro", andPrice: 5999),
        Mac(withName: "Macbook Pro", andPrice: 5999),
        Mac(withName: "Macbook Air", andPrice: 5999)
    ]
    
    let iPhones = [
        IPhone(withName: "iPhone 12", andPrice: 999),
        IPhone(withName: "iPhone 12 Pro", andPrice: 999),
        IPhone(withName: "iPhone 12 Mini", andPrice: 999),
        IPhone(withName: "iPhone 12 Pro Max", andPrice: 999)
    ]
        
    let iPads = [
        IPad(withName: "iPad", andPrice: 999),
        IPad(withName: "iPad Pro", andPrice: 999),
        IPad(withName: "iPad Air", andPrice: 999),
        IPad(withName: "iPad Mini", andPrice: 999)
    ]
}
