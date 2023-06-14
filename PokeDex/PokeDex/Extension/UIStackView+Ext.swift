//
//  UIStackView+Ext.swift
//  PokeDex
//
//  Created by Rodrigo Vart on 03/06/23.
//

import UIKit

extension UIStackView {
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
}

extension UIView {
    func removeView(view: UIView) {
        view.removeFromSuperview()
    }
    
    func removeSubviews() {
        subviews.forEach { (view) in
            removeView(view: view)
        }
    }
}
