//
//  GameDetailViewModel.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 13.12.2022.
//

import Foundation

protocol GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? { get set }
    func fetchGameDetail(id: Int)
    func getGameImageURL() -> URL?
    func getGameName() -> String
    func getGameRating() -> Double
    func getGameDescription() -> String
    func getGameGenre() -> [String]
    func getGameRelease() -> String
    
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded()
}

final class GameDetailViewModel: GameDetailViewModelProtocol {

    
    

    weak var delegate: GameDetailViewModelDelegate?
    var gameDetail: GameDetailModel?
    
    func fetchGameDetail(id: Int) {
        GameDBClient.getGameDetail(gameId: id) { [weak self] gameDetail , error in
            guard let self = self else { return }
            self.gameDetail = gameDetail
            self.delegate?.gameLoaded()
        }
    }
    
    func getGameImageURL() -> URL? {
        URL(string: gameDetail?.backgroundImage ?? "")
    }
    
    func getGameName() -> String {
        gameDetail?.name ?? ""
    }
    
    func getGameRating() -> Double {
        gameDetail?.rating ?? 0.0
    }
    
    func getGameDescription() -> String {
        gameDetail?.description ?? ""
    }
    
    func getGameGenre() -> [String] {
        guard let genres = gameDetail?.genres else { return []}
        return genres.map{ $0.name }
    }
    
    func getGameRelease() -> String {
        gameDetail?.released ?? ""
    }
    
    
}
