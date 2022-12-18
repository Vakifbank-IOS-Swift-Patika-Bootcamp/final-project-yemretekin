//
//  GameListViewController.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 6.12.2022.
//

import UIKit

final class GameListViewController: BaseViewController {
    
    var filteredData = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearched = false
    
    @IBOutlet private weak var listTableView: UITableView!{
        didSet{
            listTableView.delegate = self
            listTableView.dataSource = self
            searchBar.becomeFirstResponder()
            searchBar.delegate = self
            
        }
    }
    private var viewModel: GameListViewModelProtocol = GameListViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        listTableView.rowHeight = UITableView.automaticDimension
        indicator.startAnimating()
        viewModel.fetchPopularGames()
        indicator.stopAnimating()
    }
    
}

extension GameListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        listTableView.reloadData()
    }
    
    
}



extension GameListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearched == true {
            return filteredData.count
        }else {
            return viewModel.getGameCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  listTableView.dequeueReusableCell(withIdentifier: "listCell") as? GameListTableViewCell, let model = viewModel.getGame(at: indexPath.row) else { return UITableViewCell() }
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailViewController") as? GameDetailViewController else { return }
        detailVC.gameId = viewModel.getGameId(at: indexPath.row)
        self.navigationController?.pushViewController(detailVC, animated: true)
    
    }
    
    
}
