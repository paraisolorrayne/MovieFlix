//
//  ImageCacher.swift
//  MovieFlix
//
//  Created by Lorrayne Paraiso on 25/05/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit

class ImageCacher {
    private let cache: NSCache<NSString, UIImage>

    private init() {
        cache = NSCache<NSString, UIImage>()
    }

    static let shared = ImageCacher()

    func loadImage(for key: NSString) -> UIImage? {
        return cache.object(forKey: key)
    }

    func cache(image: UIImage, withKey key: NSString) {
        cache.setObject(image, forKey: key)
    }
}
