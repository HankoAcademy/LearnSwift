//
//  ViewController.swift
//  SFSymbols
//
//  Created by Hannie Kim on 2/26/22.
//

import UIKit

class ViewController: UIViewController {
    
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
        buttonConfiguration()
        
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
    
    // Set SFSymbol to UIImage
    func imageWithSFSymbol() {
        let bookmarkImage = UIImage(systemName: "bookmark.circle")
        imageView.image = bookmarkImage
    }
    
    // Setting image with scale configuration
    func imageWithScaleConfiguration() {
        let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let largeBookmarkImage = UIImage(systemName: "bookmark.circle", withConfiguration: largeConfiguration)
        imageView.image = largeBookmarkImage
    }
    
    // Setting image with weight configuration
    func imageWithWeightConfiguration() {
        let lightConfiguration = UIImage.SymbolConfiguration(weight: .ultraLight)
        let lightBookmarkImage = UIImage(systemName: "bookmark.circle", withConfiguration: lightConfiguration)
        imageView.image = lightBookmarkImage
    }
    
    // changing color. this can be done whether or not you're using SFSymbols for images
    func changeColor() {
        // Option 1: change color on UIImage
        let image = UIImage(systemName: "sun.min")?.withTintColor(.green, renderingMode: .alwaysOriginal)
        imageView.image = image
        
        // Option 2: change color on UIImageView
//        imageView.tintColor = .green
    }
    
    // Adding configuration to image view instead of image
    func imageViewImageConfiguration() {
        let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let bookmarkImage = UIImage(systemName: "bookmark.circle")
        imageView.image = bookmarkImage
        imageView.preferredSymbolConfiguration = largeConfiguration
    }
    
    // Button with symbol configuration
    func buttonConfiguration() {
        let sunImage = UIImage(systemName: "sun.max")
        button.setImage(sunImage, for: .normal)
        
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        button.setPreferredSymbolConfiguration(boldConfiguration, forImageIn: .normal)
    }
    
    // Multiple configurations
    func multipleConfigurations() {
        let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        let boldLargeConfiguration = largeConfiguration.applying(boldConfiguration)
        
        let bookmarkCircleImage = UIImage(systemName: "bookmark.circle")
        imageView.image = bookmarkCircleImage
        imageView.preferredSymbolConfiguration = boldLargeConfiguration
    }
}

