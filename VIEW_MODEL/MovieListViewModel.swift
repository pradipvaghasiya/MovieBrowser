//
//  MovieListViewModel.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

class MovieListViewModel{
    private var movies: [Movie]
    var cellModels: [MovieCellModel]
    
    init(movies: [Movie]){
        self.movies = movies
        cellModels = movies.map{MovieCellModel(movie: $0)}
    }
}
