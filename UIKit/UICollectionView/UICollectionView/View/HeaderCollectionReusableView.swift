//
//  HeaderCollectionReusableView.swift
//  UICollectionView
//
//  Created by Hannie Kim on 9/26/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProductHeader"
    
    private let headerlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(headerlabel)
        
        NSLayoutConstraint.activate([
            headerlabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            headerlabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerlabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(headerText: String) {
        let attributedString = NSMutableAttributedString(string: headerText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 14, range: NSRange(location: 0, length: attributedString.length))
        headerlabel.attributedText = attributedString
    }
}

class FooterCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProductFooter"
    
    private let headerlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(headerlabel)
        
        NSLayoutConstraint.activate([
            headerlabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            headerlabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerlabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(headerText: String) {
        let attributedString = NSMutableAttributedString(string: headerText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 14, range: NSRange(location: 0, length: attributedString.length))
        headerlabel.attributedText = attributedString
    }
}
