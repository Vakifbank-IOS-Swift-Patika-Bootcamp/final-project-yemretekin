//
//  GameDetailModel.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 13.12.2022.
//

import Foundation

struct GameDetailModel: Codable {
    
    let id: Int
    let name: String
    let backgroundImage: String?
    let rating: Double
    let description: String
    let genres: [Genre]
    let released: String
    
    struct Genre: Codable {
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case rating
        case description
        case genres
        case released
    }
}
