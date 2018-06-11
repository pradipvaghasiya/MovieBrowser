//
//  MovieAPI.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

private let kAPIKey = "10e624a4"
enum MovieAPI{
    case search(searchText: String)
}

extension MovieAPI: EndPoint{
    var basePath: String{
        return "http://www.omdbapi.com/"
    }
    
    var path: String{
        switch self {
        case let .search(searchText):
            return "?apikey=\(kAPIKey)&s=\(searchText)"
        }
    }
}
