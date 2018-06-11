//
//  Movie.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

struct Movie: Codable{
    let title: String
    let year: String?
    let imdbID: String?
    let type: String?
    let poster: String?
    
    enum CodingKeys: String, CodingKey{
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

