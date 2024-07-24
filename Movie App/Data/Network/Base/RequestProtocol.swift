//
//  RequestProtocol.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

public typealias RequestBody = [String: Any?]
public typealias ReaquestHeaders = [String: String]
public typealias RequestParameters = [String: Any]

protocol RequestProtocol {
    var baseURL: String? { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: ReaquestHeaders? { get }
    var parameters: RequestParameters? { get }
    var requestBody: RequestBody? { get }
    var requestType: RequestType { get }
    var responseType: ResponseType { get }
    var retryDelay: UInt64 { get }
    var retryCount: Int { get }
    var timeoutInterval: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    func verifyResponse(data: Data, response: URLResponse, with decoder: JSONDecoder) throws -> (Data, URLResponse)
    func retryHandler(response: URLResponse) async -> Bool
}

extension RequestProtocol {

    var baseURL: String? {
        return nil
    }

    var headers: ReaquestHeaders? {
        nil
    }

    var parameters: RequestParameters? {
        nil
    }

    var requestBody: RequestBody? {
        nil
    }

    var requestType: RequestType {
        .data
    }

    var responseType: ResponseType {
        .json
    }

    var retryDelay: UInt64 {
        1_000_000_000
    }

    var retryCount: Int {
        3
    }

    var timeoutInterval: TimeInterval {
        30.0
    }

    var cachePolicy: URLRequest.CachePolicy {
        .useProtocolCachePolicy
    }

    func urlRequest() -> URLRequest? {
        guard let url = url(with: baseURL) else {
            return nil
        }

        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = nil
        if let httpBody {
            request.httpBody = httpBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }

    private func url(with baseURL: String?) -> URL? {
        guard let baseURL,
              var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }

        urlComponents.path = urlComponents.path + "\(path)"
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }

    private var queryItems: [URLQueryItem]? {
        guard let parameters = parameters else {
            return nil
        }

        return parameters.map { (key: String, value: Any) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }

    private var httpBody: Data? {
        guard let requestBody else { return nil }
        return try? JSONSerialization.data(withJSONObject: requestBody, options: [])
    }

    func verifyResponse(data: Data, response: URLResponse, with decoder: JSONDecoder) throws -> (Data, URLResponse) {
        return (data, response)
    }

    func retryHandler(response: URLResponse) async -> Bool {
        return false
    }
}

