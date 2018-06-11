//
//  MemoryCache.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/23/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import UIKit

protocol MemoryImageCache{
    var cache: NSCache<NSString, UIImage> {get set}
}

extension MemoryImageCache{
    func storeImageToCache(key: String, image: UIImage){
        cache.setObject(image, forKey: key as NSString)
    }
    
    func getImageFromCache(key: String) -> UIImage?{
        return cache.object(forKey: key as NSString)
    }
    
    func clearCache(){
        cache.removeAllObjects()
    }
}
