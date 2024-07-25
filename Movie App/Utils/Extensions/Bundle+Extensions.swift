//
//  Bundle+Extensions.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

extension Bundle {
    static let app: Bundle = {
        if main.bundleURL.pathExtension == "appex" {
            let url = main.bundleURL.deletingLastPathComponent().deletingLastPathComponent()
            if let otherBundle = Bundle(url: url) {
                return otherBundle
            }
        }
        return main
    }()
}
