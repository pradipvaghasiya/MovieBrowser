//
//  UIViewController+StoryboardId.swift
//  MovieBrowser
//
//  Created by Pradip V on 5/22/18.
//  Copyright © 2018 pradip. All rights reserved.
//

import UIKit

extension UIViewController{
    class var storyboardId: String{
        return String(describing: self)
    }
}
