//
//  EndPoint.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

protocol EndPoint{
    var basePath: String{get}
    var path: String{get}
}

extension EndPoint{
    var url: URL{
        let fullPath = "\(basePath)\(path)"
        return URL(string: fullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
}
