//
//  Either.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

enum Either<T1,T2>{
    case left(T1)
    case right(T2)
}
