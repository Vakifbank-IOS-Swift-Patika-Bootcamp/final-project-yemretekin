//
//  GameListViewModel.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 13.12.2022.
//

import Foundation

protocol GameListViewModelProtocol {
    var delegate: GameListViewModelDelegate? { get set }
    func fetchPopularGames()
    func getGameCount() -> Int
    func getGame(at index: Int) -> GameListModel?
    func getGameId(at index: Int) -> Int?
    func searchGames(query: String)
    func getGameReleased(at index: Int) -> String?
}

protocol GameListViewModelDelegate: AnyObject {
    func gamesLoaded()
}

final class GameListViewModel:GameListViewModelProtocol {
    
    var delegate: GameListViewModelDelegate?
    private var games: [GameListModel]?
    
    func fetchPopularGames() {
        GameDBClient.getLastDecadePopularGames {[weak self] games, error in
            guard let self = self else { return }
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> GameListModel? {
        games?[index]
    }
    
    func getGameId(at index: Int) -> Int? {
        games?[index].id
    }
    
    func getGameReleased(at index: Int) -> String? {
        games?[index].released
    }
    
    func searchGames(query: String) {
        
    }
    
    
}
