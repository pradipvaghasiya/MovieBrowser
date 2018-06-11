//
//  MockURLSessionDataTask.swift
//  MovieBrowserTests
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

@testable import MovieBrowser

class MockURLSessionDataTask: URLSessionDataTaskProtocol{
    var resumeCalled = false
    func resume() {
        resumeCalled = true
    }
}
