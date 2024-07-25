//
//  String+Random.swift
//  Movie AppTests
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

extension String {
    static func random(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""

        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)]
            randomString += String(newCharacter)
        }

        return randomString
    }
}
