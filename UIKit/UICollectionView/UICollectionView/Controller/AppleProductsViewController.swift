//
//  AppleProductsViewController.swift
//  UICollectionView
//
//  Created by Hannie Kim on 9/25/21.
//

import UIKit

class AppleProductsViewController: UIViewController {

    // MARK: Class Properties
    
    let appleProducts: AppleProducts
    
    // MARK: - UI Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/3.5, height: view.frame.size.width/3)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductDetailCollectionViewCell.self, forCellWithReuseIdentifier: ProductDetailCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Initializer
    
    init(appleProducts: AppleProducts) {
        self.appleProducts = appleProducts
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension AppleProductsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProductType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCollectionViewCell.identifier, for: indexPath) as? ProductDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch ProductType(rawValue: indexPath.section) {
        case .macs:
            let mac = appleProducts.macs[indexPath.row]
            cell.configure(name: mac.name, price: mac.price)
            return cell
        case .iphone:
            let iPhone = appleProducts.iPhones[indexPath.row]
            cell.configure(name: iPhone.name, price: iPhone.price)
            return cell
        case .ipad:
            let iPad = appleProducts.iPads[indexPath.row]
            cell.configure(name: iPad.name, price: iPad.price)
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch ProductType(rawValue: section) {
        case .macs:
            return appleProducts.macs.count
        case .iphone:
            return appleProducts.iPhones.count
        case .ipad:
            return appleProducts.iPads.count
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            switch ProductType(rawValue: indexPath.section) {
            case .macs:
                headerView.configure(headerText: "Macs")
            case .iphone:
                headerView.configure(headerText: "iPhones")
            case .ipad:
                headerView.configure(headerText: "iPads")
            case .none:
                return UICollectionReusableView()
            }
            
            return headerView
        }
        else if kind == UICollectionView.elementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath) as? FooterCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            switch ProductType(rawValue: indexPath.section) {
            case .macs:
                footerView.configure(headerText: "Macs Footer")
            case .iphone:
                footerView.configure(headerText: "iPhones Footer")
            case .ipad:
                footerView.configure(headerText: "iPads Footer")
            case .none:
                return UICollectionReusableView()
            }
            
            return footerView
        }
        
        return UICollectionReusableView()
    }
}

extension AppleProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}

extension AppleProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section: \(indexPath.section) Row: \(indexPath.row)")
    }
}
