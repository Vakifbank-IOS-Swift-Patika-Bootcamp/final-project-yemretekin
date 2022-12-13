//
//  GameListModel.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 12.12.2022.
//

import Foundation

struct GameListModel: Decodable {
    let id: Int
    let name: String
    let backgroundImage: String
    let rating: Double
    let released: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case rating
        case released
    }
}
