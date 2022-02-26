//
//  ViewController.swift
//  SFSymbols
//
//  Created by Hannie Kim on 2/26/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addImageView()
    }

    func addImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // to use an image saved in Assets.xcassets instead
//        imageView.image = UIImage(named: "shareIcon")
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .large)
        let imageWithConfig = UIImage(systemName: "arrow.clockwise.circle", withConfiguration: configuration)
        
        // sets the color
        imageView.tintColor = .green
        
        imageView.image = imageWithConfig
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

