//
//  Result.swift
//  MovieFlix
//
//  Created by Lorrayne Paraiso on 25/05/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(ClientError)
}
