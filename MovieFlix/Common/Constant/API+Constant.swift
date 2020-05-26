//
//  API+Constant.swift
//  MovieFlix
//
//  Created by Lorrayne Paraiso on 25/05/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

enum API {

    static let key = "1f54bd990f1cdfb230adb312546d765d"

    enum URL {
        static let base = "https://api.themoviedb.org/3"
        static let image = "https://image.tmdb.org/t/p/w500"
    }

    enum Path {
        static let upcoming = "/movie/upcoming"
        static let genre = "/genre/movie/list"
        static let search = "/search/movie"
    }
}
