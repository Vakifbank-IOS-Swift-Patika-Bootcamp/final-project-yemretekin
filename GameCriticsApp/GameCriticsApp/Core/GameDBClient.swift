//
//  GameDBClient.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 13.12.2022.
//

import Foundation
import Alamofire

final class GameDBClient {
    static let BASE_URL = "https://api.rawg.io/api"
    static let IMAGE_BASE_URL = "https://media.rawg.io/media"
    
    static func getLastDecadePopularGames(completion: @escaping ([GameListModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "/games" + "?dates=2012-12-31,2022-12-31&ordering=-added" + "&key=" + Constants.API_KEY
        handleResponse(urlString: urlString, responseType: GetGameListResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    static func getGameDetail(gameId: Int, completion: @escaping (GameDetailModel?, Error?) -> Void) {
        let urlString = BASE_URL + "/games/" + String(gameId) + "?key=" + Constants.API_KEY
        handleResponse(urlString: urlString, responseType: GameDetailModel.self, completion: completion)
    }
    
    static private func handleResponse<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        AF.request(urlString).response { response in
            guard let data = response.value else {
                DispatchQueue.main.async {
                    completion(nil, response.error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
}
