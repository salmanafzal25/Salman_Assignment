//
//  DetailResponseModel.swift
//  Salman_Assignment
//
//  Created by SalmanAfzal on 28/06/2021.
//

import Foundation

// MARK: - Welcome
struct MovieDetailResponseModel: Codable {

    let backdropPath: String?
    let originalTitle, overview: String?
    let releaseDate: String?
    let genres: [Genre]?
 

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case overview, genres
        case releaseDate = "release_date"
      
    }
}


struct Genre: Codable {
    let id: Int?
    let name: String?
}
