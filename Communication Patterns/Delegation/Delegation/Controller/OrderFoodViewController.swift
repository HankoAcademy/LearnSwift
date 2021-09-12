//
//  OrderFoodViewController.swift
//  Delegation
//
//  Created by Hannie Kim on 9/11/21.
//

import UIKit

protocol FoodOrdering: AnyObject {
    func order(food: String)
}

class OrderFoodViewController: UIViewController {

    // MARK: - Class Properties
    
    weak var foodOrderingDelegate: FoodOrdering?
    
    // MARK: - UI Setup
    
    var orderFoodView: OrderFoodView!
            
    // MARK: - Initializer
    
    init(foodOrderingDelegate: FoodOrdering?) {
        self.foodOrderingDelegate = foodOrderingDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        orderFoodView = OrderFoodView(foodOrderingDelegate: foodOrderingDelegate)
        view = orderFoodView
    }
}
