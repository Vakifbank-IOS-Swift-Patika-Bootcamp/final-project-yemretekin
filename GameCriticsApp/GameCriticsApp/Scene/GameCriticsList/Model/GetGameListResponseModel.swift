//
//  GetGameListResponseModel.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 13.12.2022.
//

import Foundation

struct GetGameListResponseModel: Decodable {
    let results: [GameListModel]
}
