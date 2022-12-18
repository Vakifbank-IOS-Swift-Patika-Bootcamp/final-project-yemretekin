//
//  GameFavoritesViewController.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 18.12.2022.
//

import UIKit

class GameFavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!{
        didSet{
            favoriteTableView.delegate = self
            favoriteTableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = CoreDataManager.shared.getGame()

    }
    


}

extension GameFavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favCell") else { return UITableViewCell() }
        
        return cell
    }
    
    
}
