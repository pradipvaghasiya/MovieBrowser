//
//  MovieCell.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import UIKit


private let kUniqueId = "MovieCell"
class MovieCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    class var uniqueId: String{
        return kUniqueId
    }
    
    func configure(cellModel: MovieCellModel){
        movieTitleLabel.text = cellModel.name
        loadMoviePoster(cellModel: cellModel)
    }
    
    ///Property needed to cross check whether cell has been re-used post image download
    private var myThumbnailId: String? = nil
    private func loadMoviePoster(cellModel: MovieCellModel){
        posterImageView.image = nil
        guard let thumbnail = cellModel.thumbnail else{
            return
        }
        let downloadingThumbnailId = thumbnail.uniqueName
        myThumbnailId = thumbnail.uniqueName
        let image = ThumbnailLoader.shared.fetchThumbnail(thumbnail: thumbnail){
            [weak self] image in
            //Loaded from network
            guard downloadingThumbnailId == self?.myThumbnailId else{
                //Cell is reused so ignore this image for now.
                return
            }
            self?.posterImageView.image = image
        }
        //Loaded from Memory or Disk
        posterImageView.image = image
    }
}
