//
//  Upcoming.swift
//  MovieFlix
//
//  Created by Lorrayne Paraiso on 25/05/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit

struct Upcoming {
    struct Movie {
        let id: Int
        let title: String
        let originalTitle: String
        let poster: String
        let backdrop: String
        let genres: String
        let releaseDate: String
        let overview: String
    }
    let movies: [Movie]
    let totalPages: Int
}
