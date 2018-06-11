//
//  SearchRouter.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import UIKit

enum SearchRouter{
    case toMovieList((UIViewController, [Movie]))
}

extension SearchRouter: Router{
    func go() {
        switch self {
        case let .toMovieList((fromVC, movies)):
            guard let movieListVC = fromVC.storyboard?.instantiateViewController(withIdentifier: MovieListVC.storyboardId) as? MovieListVC else{
                return
            }
            movieListVC.movieListViewModel = MovieListViewModel(movies: movies)
            fromVC.navigationController?.pushViewController(movieListVC, animated: true)
        }
    }
}
