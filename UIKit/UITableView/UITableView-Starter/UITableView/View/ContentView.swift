//
//  ContentView.swift
//  UITableView
//
//  Created by Hannie Kim on 9/10/21.
//

import UIKit

class ContentView: UIView {

    // MARK: - UI Properties
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        
    }
}
