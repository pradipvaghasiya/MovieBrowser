//
//  Thumbnail.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/23/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

struct Thumbnail{
    let url: URL
    let uniqueName: String
    
    init(url: URL, uniqueName: String){
        self.url = url
        self.uniqueName = uniqueName
    }
}
