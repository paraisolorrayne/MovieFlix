//
//  GenresResponseModel.swift
//  MovieFlix
//
//  Created by Lorrayne Paraiso on 26/05/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

struct GenresResponseModel: Decodable {
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    let genres: [Genre]
}
