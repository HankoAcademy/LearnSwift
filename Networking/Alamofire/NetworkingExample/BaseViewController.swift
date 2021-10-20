//
//  BaseViewController.swift
//  NetworkingExample
//
//  Created by Hannie Kim on 10/12/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    let child = SpinnerViewController()
    
    func addSpinner() {
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeSpinner() {
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
