//
//  GameListTableViewCell.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 6.12.2022.
//

import UIKit
import AlamofireImage

class GameListTableViewCell: UITableViewCell {

    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    @IBOutlet weak var gameImage: UIImageView!{
        didSet{
            gameImage.layer.cornerRadius = 50.0
            gameImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var gameReleased: UILabel!
    
    func configure(model: GameListModel) {
        self.gameName.text = "🎮 \(model.name)"
        self.gameRating.text = "⭐️ \(model.rating) / 5"
        self.gameReleased.text = "🗓️ \(model.released)"
        
        guard let url = URL(string: model.backgroundImage) else { return }
        gameImage.af.setImage(withURL: url)
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }
    
}
