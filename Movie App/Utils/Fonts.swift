//
//  Fonts.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

enum Fonts {

    private enum Constants {
        static let title1FontSize = CGFloat(25)
        static let body1FontSize = CGFloat(16)
        static let body2FontSize = CGFloat(14)
    }

    enum Title1 {
        static var bold = UIFont.boldSystemFont(ofSize: Constants.title1FontSize)
    }

    enum Body1 {
        static var medium = UIFont.systemFont(ofSize: Constants.body1FontSize)
    }

    enum Body2 {
        static var medium = UIFont.systemFont(ofSize: Constants.body2FontSize)
    }
}
