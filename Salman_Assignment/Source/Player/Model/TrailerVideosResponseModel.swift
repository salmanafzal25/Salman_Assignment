//
//  TrailerVideosResponseModel.swift
//  Salman_Assignment
//
//  Created by SalmanAfzal on 28/06/2021.
//

import Foundation


struct TrailerVideosResponseModel: Codable {
    let id: Int?
    let results: [TrailerVideo]?
}

struct TrailerVideo: Codable {
    let key: String?
    let name, site: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case key, name, site, size, type
    }
}
