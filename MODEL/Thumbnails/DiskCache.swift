//
//  DiskCache.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/23/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import UIKit

protocol DiskCache{
    var cacheDirectory: URL {get}
}

extension DiskCache where Self: ThumbnailLoaderType{    
    func storeImageToDisk(name: String, image: UIImage){
        do{
            guard let data = UIImageJPEGRepresentation(image, compressionQuality) else{
                return
            }
            try data.write(to: cacheDirectory.appendingPathComponent(name), options: .atomic)
        }catch let error{
            print(error)
        }
    }
    
    func getImageFromDisk(name: String) -> UIImage?{
        do{
            let data = try Data(contentsOf: cacheDirectory.appendingPathComponent(name))
            return UIImage(data: data)
        }catch{
            return nil
        }
    }
}
