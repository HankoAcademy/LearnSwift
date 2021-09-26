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
    
    private var contentView: ContentView!
    private var collectionView: UICollectionView!
    
    init(appleProducts: AppleProducts) {
        self.appleProducts = appleProducts
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        contentView = ContentView()
        view = contentView
        
        collectionView = contentView.collectionView
//        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension AppleProductsViewController: UICollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProductType.allCases.count
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCollectionViewCell.identifier, for: indexPath) as? ProductDetailCollectionViewCell else {
            assertionFailure("Expected to dequeue \(ProductDetailCollectionViewCell.self) but found nil")
            return UICollectionViewCell()
        }
        
        switch ProductType(rawValue: indexPath.section) {
        case .macs:
            let mac = appleProducts.macs[indexPath.row]
            cell.configure(name: mac.name, price: mac.price)
            return cell
        case .iphone:
            let iphone = appleProducts.iPhones[indexPath.row]
            cell.configure(name: iphone.name, price: iphone.price)
            return cell
        case .ipad:
            let ipad = appleProducts.iPads[indexPath.row]
            cell.configure(name: ipad.name, price: ipad.price)
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else {
            assertionFailure("Could not dequeue \(HeaderCollectionReusableView.self)")
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
}

//extension AppleProductsViewController: UICollectionViewDelegate {
//
//}
//
extension AppleProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}
