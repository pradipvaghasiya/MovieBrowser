//
//  SearchViewModel.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import Foundation

private let kUnknownError = "Could not fetch Movies. Please try again."

protocol SearchViewModelDelegate: class{
    func moviesFound(movies: [Movie])
    func showError(error: String)
    func loading(_ show: Bool)
}

class SearchViewModel{
    weak var delegate: SearchViewModelDelegate?
}

extension SearchViewModel{
    func search(searchText: String){
        guard validateSearchString(searchText: searchText) else{
            informErrorOccured(error: "Invalid String")
            return
        }
        
        let endpoint = MovieAPI.search(searchText: searchText)
        delegate?.loading(true)
        Networking.shared.performRequest(endPoint: endpoint, type: MovieSearch.self){
            [weak self] response in
            switch(response){
            case let .left(movieSearch):
                guard let error = movieSearch.error else{
                    guard let movies = movieSearch.movies else{
                        self?.informErrorOccured(error: kUnknownError)
                        return
                    }
                    self?.informMoviesFound(movies: movies)
                    return
                }
                self?.informErrorOccured(error: error)
            case .right:
                self?.informErrorOccured(error: kUnknownError)
            }
        }
    }
    
    private func validateSearchString(searchText: String) -> Bool{
        return searchText.count > 0
    }
    
    private func informMoviesFound(movies: [Movie]){
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.moviesFound(movies: movies)
            self?.delegate?.loading(false)
        }
    }
    
    private func informErrorOccured(error: String){
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.showError(error: error)
            self?.delegate?.loading(false)
        }
    }
}

