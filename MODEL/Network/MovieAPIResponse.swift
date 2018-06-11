//
//  MovieAPI+Response.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

typealias MovieAPIResponse<T> = (Either<T, MovieAPIResponseError>) -> Void

enum MovieAPIResponseError: Error{
    case networkError(String)
    case parseError
}
