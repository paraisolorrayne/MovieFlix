//
//  UIImageView+ImageDownloader.swift
//  MovieFlix
//
//  Created by Lorrayne Paraiso on 26/05/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: String) {
        let imageDownloader = ImageDownloader()
        guard let imageUrl = URL(string: url) else { return }
        
        imageDownloader.loadImage(from: imageUrl) { (image) in
            self.image = image
        }
    }
}
