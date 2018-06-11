//
//  MovieCellModel.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import UIKit

struct MovieCellModel{
    let name: String
    let thumbnail: Thumbnail?
    
    init(movie: Movie){
        self.name = movie.title
        if let imdbId = movie.imdbID,
            let posterURLString = movie.poster,
            let posterURL = URL(string: posterURLString){
            self.thumbnail = Thumbnail(url: posterURL, uniqueName: imdbId)
        }else{
            self.thumbnail = nil
        }
    }
}
