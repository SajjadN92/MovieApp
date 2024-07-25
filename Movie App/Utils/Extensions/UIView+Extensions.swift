//
//  UIView+Extensions.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

extension UIView {

    static var nib: UINib {
        UINib(nibName: String(describing: Self.self), bundle: Bundle(for: self))
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
        }
    }
}
