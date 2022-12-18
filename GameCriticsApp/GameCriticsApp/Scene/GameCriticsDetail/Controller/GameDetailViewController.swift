//
//  GameDetailViewController.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 13.12.2022.
//

import UIKit

final class GameDetailViewController: BaseViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gameDetailName:UILabel!
    @IBOutlet weak var gameDetailDescription:UILabel!
    @IBOutlet weak var gameDetailRating:UILabel!
    @IBOutlet weak var gameDetailGenres:UILabel!
    @IBOutlet weak var gameDetailImage: UIImageView!
    
    var gameId : Int?
    private var viewModel: GameDetailViewModelProtocol = GameDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = gameId else { return }
        viewModel.delegate = self
        indicator.startAnimating()
        viewModel.fetchGameDetail(id: id)
        indicator.stopAnimating()
        
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        
        _ = CoreDataManager.shared.saveGame(gameName: viewModel.getGameName(), gameRating: String(viewModel.getGameRating()), gameRelease: viewModel.getGameRelease())
        
    }
    
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        gameDetailName.text = "Game Name: \(viewModel.getGameName())"
        gameDetailRating.text = "Rating: \(String(viewModel.getGameRating())) / 5"
        gameDetailDescription.text = "Description: \n\(viewModel.getGameDescription())"
        gameDetailGenres.text = "Genre: \(viewModel.getGameGenre().joined(separator: ","))"
        guard let url = viewModel.getGameImageURL() else { return }
        gameDetailImage.af.setImage(withURL: url)
        
    }
    
    
}
