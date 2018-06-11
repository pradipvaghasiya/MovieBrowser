//
//  ViewController.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var searchMovieTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var searchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        configureTextField()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

///ViewModel Mapping
extension SearchVC : SearchViewModelDelegate{
    func configureViewModel(){
        searchViewModel.delegate = self
        errorLabel.isHidden = true
        searchButton.isEnabled = false
    }
    
    func moviesFound(movies: [Movie]) {
        SearchRouter.toMovieList((self, movies)).go()
    }
    
    func showError(error: String) {
        errorLabel.text = error
        errorLabel.isHidden = false
    }
    
    func loading(_ show: Bool) {
        if show{
            searchButton.isHidden = true
            indicator.startAnimating()
            errorLabel.isHidden = true
        }else{
            searchButton.isHidden = false
            indicator.stopAnimating()
        }
    }
}

///Search
extension SearchVC: UITextFieldDelegate{
    func configureTextField(){
        searchMovieTextField.delegate = self
        searchMovieTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchNow()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        searchButton.isEnabled = (textField.text ?? "").count > 0
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        searchNow()
    }
    
    private func searchNow(){
        searchViewModel.search(searchText: searchMovieTextField.text ?? "")
    }

}

