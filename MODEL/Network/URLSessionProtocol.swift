//
//  Networking+Testable.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

///This will help to mock URLSession in Unit Testing
protocol URLSessionProtocol{
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTaskProtocol
}

extension URLSession : URLSessionProtocol{
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
