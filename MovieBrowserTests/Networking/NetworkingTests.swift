//
//  NetworkingTests.swift
//  MovieBrowserTests
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import XCTest

@testable import MovieBrowser

class NetworkingTests: XCTestCase {

    var mockNetworking: Networking!
    var mockURLSessionDataTask : MockURLSessionDataTask!
    var mockURLSession : MockURLSession!

    override func setUp() {
        super.setUp()
        
        mockURLSessionDataTask = MockURLSessionDataTask()
        mockURLSession = MockURLSession(mockDataTask: mockURLSessionDataTask)
        mockNetworking = Networking(session: mockURLSession)
    }
    
    func testRightURLCalled(){
        let endPoint = MovieAPITestEnum.rightURLCalled
        mockNetworking.performRequest(endPoint: endPoint, type: MovieSearch.self){_ in
            
        }
        XCTAssertEqual(mockURLSession.lastURLCalled, endPoint.url)
    }
    
    func testResumeCalled(){
        let endPoint = MovieAPITestEnum.rightURLCalled
        mockNetworking.performRequest(endPoint: endPoint, type: MovieSearch.self){_ in
            
        }
        XCTAssert(mockURLSessionDataTask.resumeCalled)
    }
    
    func testNoMoviesFound(){
        let endPoint = MovieAPITestEnum.noMoviesFound
        mockNetworking.performRequest(endPoint: endPoint, type: MovieSearch.self){response in
            switch(response){
            case let .left(movieSearch):
                XCTAssertNil(movieSearch.movies)
                XCTAssertNotNil(movieSearch.error)
            case .right:
                XCTAssert(false)
            }
        }
    }
    
    func testMoreThan1MoviesFound(){
        let endPoint = MovieAPITestEnum.moreThan1MoviesFound
        mockNetworking.performRequest(endPoint: endPoint, type: MovieSearch.self){response in
            switch(response){
            case let .left(movieSearch):
                XCTAssert(movieSearch.movies!.count > 1)
            case .right:
                XCTAssert(false)
            }
        }
    }
    
    func testMoviesListTooLong(){
        let endPoint = MovieAPITestEnum.moviesListTooLong
        mockNetworking.performRequest(endPoint: endPoint, type: MovieSearch.self){response in
            switch(response){
            case let .left(movieSearch):
                XCTAssertNil(movieSearch.movies)
                XCTAssertNotNil(movieSearch.error)
            case .right:
                XCTAssert(false)
            }
        }
    }
    
    func testInvalidAPIKey(){
        let endPoint = MovieAPITestEnum.invalidAPIKey
        mockNetworking.performRequest(endPoint: endPoint, type: MovieSearch.self){response in
            switch(response){
            case let .left(movieSearch):
                XCTAssertNil(movieSearch.movies)
                XCTAssertNotNil(movieSearch.error)
            case .right:
                XCTAssert(false)
            }
        }
    }
    
    func testInvalidJson(){
        let endPoint = MovieAPITestEnum.invalidJSON
        mockNetworking.performRequest(endPoint: endPoint, type: MovieSearch.self){response in
            switch(response){
            case .left:
                XCTAssert(false)
            case .right(let error):
                guard case MovieAPIResponseError.parseError = error else{
                    XCTAssert(false)
                    return
                }
                XCTAssert(true)
            }
        }
    }
    
    func testNetworkError(){
        let endPoint = MovieAPITestEnum.networkError
        mockNetworking.performRequest(endPoint: endPoint, type: MovieSearch.self){response in
            switch(response){
            case .left:
                XCTAssert(false)
            case .right(let error):
                guard case let MovieAPIResponseError.networkError(error) = error else{
                    XCTAssert(false)
                    return
                }
                XCTAssertNotNil(error)
            }
        }
    }
}
