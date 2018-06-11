//
//  URLSessionDataTaskProtocol.swift
//  MovieBrowserTests
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

//This will help to mock URLSessionDataTask in Unit Testing
protocol URLSessionDataTaskProtocol{
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol{
    
}
