//
//  UIViewController+Extensions.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

extension UIViewController {
    private static var name: String {
        String(describing: Self.self)
    }

    static var storyboard: UIStoryboard {
        UIStoryboard(name: name, bundle: nil)
    }

    static func instantiateViewController<ViewController>(
        creator: ((NSCoder) -> ViewController?)?
    ) -> ViewController where ViewController: UIViewController {
        return storyboard.instantiateViewController(identifier: name, creator: creator)
    }
}
