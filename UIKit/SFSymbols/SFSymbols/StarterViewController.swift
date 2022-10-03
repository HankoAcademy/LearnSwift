//
//  StarterViewController.swift
//  SFSymbols
//
//  Created by Hannie Kim on 10/3/22.
//

import UIKit

class StarterViewController: UIViewController {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        imageViewWithImageAsset()
        addButton()
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(button)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // to use an image saved in Assets.xcassets instead of SFSymbols
    func imageViewWithImageAsset() {
        imageView.image = UIImage(named: "shareIcon")
    }
    
    // button using placeholder image from Assets catalog
    func addButton() {
        button.setImage(UIImage(named: "shareIcon"), for: .normal)
    }
    
    // Set SFSymbol to UIImage
    func imageWithSFSymbol() {
        
    }
    
    // Setting image with scale configuration
    func imageWithScaleConfiguration() {
        
    }
    
    // Setting image with weight configuration
    func imageWithWeightConfiguration() {
        
    }
    
    // changing color. this can be done whether or not you're using SFSymbols for images
    func changeColor() {
        
    }
    
    // Adding configuration to image view instead of image
    func imageViewImageConfiguration() {
        let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let bookmarkImage = UIImage(systemName: "bookmark.circle")
        imageView.image = bookmarkImage
        imageView.preferredSymbolConfiguration = largeConfiguration
    }
    
    // Adding configuration to button instead of image
    func buttonConfiguration() {
        
    }
    
    // Multiple configurations
    func multipleConfigurations() {
        
    }
}
