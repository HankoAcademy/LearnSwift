//
//  ContentView.swift
//  UIScrollView
//
//  Created by Hannie Kim on 9/8/21.
//

import UIKit

class ContentView: UIView {
    
    // UIScrollView property
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // View property that will be added as the content view of our UIScrollView
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        backgroundColor = .white
        
        addSubview(scrollView)
        
        // Scroll view contrains to its superview edges
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        /**
         A UIScrollView will only add the ability to scroll if its contents expand further than it's height or width.
         Since scrollView constrainted to its superview edges, which will take up the full screen of the ViewController(), no more and no less, it won't scroll unless its contents exceed its current width or height.
    
         contentView is a container where you could add multiple views into but currently it's just a simple UIView with a blue background.
         If contentView's width exceeds the width of the scrollView, you'll see the horizontal scroll capability.
         If contentView's height exceeds the height of the scrollView, you'll see the vertical scroll capability.
         */
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            /*
             If you uncommment Line 73 and comment Line 73, you'll see the horizontal scroll ability removed since the width of the subviews (contentView) of scrollView
             is now less than or equal to the scrollView's width
             */
            
            // contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 100), // gives the ability to scroll horizontally
            
            /*
             If you uncommment Line 81 and comment Line 82, you'll see the vertical scroll ability removed since the height of the subviews (contentView) of scrollView
             is now less than or equal to the scrollView's height
             */
            
//            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 100)
        ])
    }
}

/*
 Note: UIScrollView was constrained to the edges of its superview, the superview being ViewController's view. That means, the views inside of UIScrollView shouldn't extend beyond the x-coordinate or y-coordinate constraints, BUTTT if it does then you get the capability to scroll horizontally (x-axis) or vertically (y-axis).
 */

