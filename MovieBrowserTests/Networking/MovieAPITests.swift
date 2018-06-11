//
//  MovieAPITests.swift
//  MovieBrowserTests
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import XCTest

@testable import MovieBrowser

enum MovieAPITestEnum: String, EndPoint{
    case rightURLCalled = "http://www.omdbapi.com/rightURLCalled"
    case noMoviesFound = "http://www.omdbapi.com/noMoviesFound"
    case moreThan1MoviesFound = "http://www.omdbapi.com/moreThan1MoviesFound"
    case moviesListTooLong = "http://www.omdbapi.com/moviesListTooLong"
    case invalidAPIKey = "http://www.omdbapi.com/invalidAPIKey"
    case invalidJSON = "http://www.omdbapi.com/invalidJSON"
    case networkError = "http://www.omdbapi.com/networkError"
}


extension MovieAPITestEnum{
    var basePath: String{
        return "http://www.omdbapi.com/"
    }
    
    var path: String{
        switch self {
        case .rightURLCalled:
            return "rightURLCalled"
        case .noMoviesFound:
            return "noMoviesFound"
        case .moreThan1MoviesFound:
            return "moreThan1MoviesFound"
        case .moviesListTooLong:
            return "moviesListTooLong"
        case .invalidAPIKey:
            return "invalidAPIKey"
        case .invalidJSON:
            return "invalidJSON"
        case .networkError:
            return "networkError"
        }
    }
}


extension MovieAPITestEnum{
    var networkResponse: Either<Data, Error>{
        switch self {
        case .rightURLCalled:
            return Either.left(try! JSONSerialization.data(withJSONObject:  [
                "Response": "True"], options: .init(rawValue: 0)))
        case .noMoviesFound:
            return Either.left(try! JSONSerialization.data(withJSONObject:  [
                "Response": "True",
                "Error": "Movie not found!"], options: .init(rawValue: 0)))
        case .moreThan1MoviesFound:
            return Either.left(try! JSONSerialization.data(withJSONObject:  [
                "Response": "True",
                "Search": [["Title": "Title1"], ["Title": "Title2"]],
                "totalResults": "2"], options: .init(rawValue: 0)))
        case .moviesListTooLong:
            return Either.left(try! JSONSerialization.data(withJSONObject:  [
                "Response": "False",
                "Error": "Too many results."], options: .init(rawValue: 0)))
        case .invalidAPIKey:
            return Either.left(try! JSONSerialization.data(withJSONObject:  [
                "Response": "False",
                "Error": "Invalid API key!"], options: .init(rawValue: 0)))
        case .invalidJSON:
            return Either.left(Data())
        case .networkError:
            return Either.right(NSError(domain:"Network Error", code:500, userInfo:nil))
        }
    }
}
