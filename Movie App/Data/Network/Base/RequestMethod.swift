//
//  RequestMethod.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

public enum RequestMethod: String {
    /// HTTP GET
    case get = "GET"
    /// HTTP POST
    case post = "POST"
    /// HTTP PUT
    case put = "PUT"
    /// HTTP PATCH
    case patch = "PATCH"
    /// HTTP HEAD
    case head = "HEAD"
    /// HTTP DELETE
    case delete = "DELETE"
}
