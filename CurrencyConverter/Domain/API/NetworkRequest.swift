//
//  NetworkRequest.swift
//  CurrencyConverter
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import Foundation

enum HttpVerb: String {
    
    case get = "GET"
    
}

protocol NetworkRequest {
    
    var path: String { get }
    var method: HttpVerb { get }
    var parameters: [String: Any]? { get }
    
}

extension NetworkRequest {
    
    private var baseUrl: String {
        "https://my.transfergo.com/api/"
    }
    
    private var url: URL? {
        guard var urlComponents = URLComponents(string: baseUrl) else { return nil }
        urlComponents.path += path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    public func urlRequest() -> URLRequest? {
        guard let url = url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        // If headers are different for different requests this could be also added to the NetworkRequest protocol.
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        return urlRequest
    }
    
    private var queryItems: [URLQueryItem]? {
        // Chek if it is a GET method.
        guard method == .get, let parameters = parameters else {
            return nil
        }
        // Convert parameters to query items.
        return parameters.map { (key: String, value: Any) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }
    
}
