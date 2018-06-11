//
//  MoviePosterLoader.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/23/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import UIKit

private let kCompressionQuality: CGFloat = 0.75
private let kThumbnailDirectory: String = "thumbnails"

class ThumbnailLoader{
    public static let shared = ThumbnailLoader()
    private init(){
        createThumbnailDirectory()
        observeLowMemoryNotification()
    }
    
    deinit {
        unObserveLowMemoryNotification()
    }
    
    //DiskCache
    lazy var cacheDirectory: URL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(kThumbnailDirectory)
    
    //MemoryCache
    lazy var cache: NSCache<NSString, UIImage> = NSCache()
}


extension ThumbnailLoader: ThumbnailLoaderType{
    var compressionQuality: CGFloat{
        return kCompressionQuality
    }
}

extension ThumbnailLoader: DiskCache{
    private func createThumbnailDirectory(){
        do{
            try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }catch let error{
            print("Failed to create Thumbnail Directory: \(error.localizedDescription)")
        }
    }
}

extension ThumbnailLoader: MemoryImageCache{
    
}

///Fetch Image
extension ThumbnailLoader{
    func fetchThumbnail(thumbnail: Thumbnail, onComplete: @escaping (UIImage)->Void) -> UIImage?{
        //Memory Cache Hit
        if let image = getImageFromCache(key: thumbnail.uniqueName){
            print("Memory Cache Hit")
            return image
        }
        
        //Disk Cache Hit
        if let image = getImageFromDisk(name: thumbnail.uniqueName){
            print("Disk Cache Hit")
            // Store to memory Cache and return
            storeImageToCache(key: thumbnail.uniqueName, image: image)
            return image
        }
        
        //Fetch From Network
        print("Fetch From Network..")
        DispatchQueue.global().async { [weak self] in
            do{
                let data = try Data(contentsOf: thumbnail.url)
                guard let image = UIImage(data: data) else{
                    return
                }
                //Store image to memory and disk cache
                self?.storeImageToCache(key: thumbnail.uniqueName, image: image)
                self?.storeImageToDisk(name: thumbnail.uniqueName, image: image)
                
                DispatchQueue.main.async {
                    onComplete(image)
                }
            }catch let error{
                print(" ****  Failed to download ****")
                print(error.localizedDescription)
                print(thumbnail.uniqueName)
                print(thumbnail.url)
            }
        }
        return nil  //Not found in cache
    }
}

//In case of Low Memory 
extension ThumbnailLoader{
    func observeLowMemoryNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveLowMemoryWarning), name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    func unObserveLowMemoryNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didReceiveLowMemoryWarning(){
        clearCache()
    }
}
