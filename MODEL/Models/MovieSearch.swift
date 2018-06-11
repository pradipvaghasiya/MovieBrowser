//
//  MovieSearch.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

enum MovieResultResponse: String, Codable{
    case isTrue = "True"
    case isFalse = "False"
}

struct MovieSearch: Codable{
    let movies: [Movie]?
    let response: MovieResultResponse
    let error: String?
    let totalResults: String?
    
    enum CodingKeys: String, CodingKey{
        case movies = "Search"
        case response = "Response"
        case error = "Error"
        case totalResults = "totalResults"
    }
}
