//
//  OrderFoodViewController.swift
//  Delegation
//
//  Created by Hannie Kim on 9/11/21.
//

import UIKit

class OrderFoodViewController: UIViewController {

    // MARK: - Class Properties
    
    var orderFood: ((String) -> Void)
    
    // MARK: - UI Setup
    
    var orderFoodView: OrderFoodView!
            
    // MARK: - Initializer
    
    init(orderFood: @escaping (String) -> Void) {
        self.orderFood = orderFood
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        
        orderFoodView = OrderFoodView(orderFood: orderFood)
        view = orderFoodView
    }
}
