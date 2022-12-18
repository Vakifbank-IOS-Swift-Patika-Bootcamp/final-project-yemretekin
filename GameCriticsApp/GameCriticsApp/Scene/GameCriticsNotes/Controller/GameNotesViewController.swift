//
//  GameNotesViewController.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 17.12.2022.
//

import UIKit


protocol ReloadDelegate {
    func reloadTableView()
}

class GameNotesViewController: UIViewController {

    

    @IBOutlet weak var notesTableView: UITableView!{
        didSet{
            notesTableView.delegate = self
            notesTableView.dataSource = self
        }
    }
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.rowHeight = UITableView.automaticDimension
        updateTable()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toNoteDetail":
            if let note = sender as? Note {
                let detailVC = segue.destination as! GameNotesDetailViewController
                detailVC.delegate = self
                detailVC.note = note
            }
        case "toAddNote":
            let detailVC = segue.destination as! GameNotesDetailViewController
            detailVC.delegate = self
        default :
            print("Unknown")
        }
    }
    
    func updateTable() {
        notes = CoreDataManager.shared.getNotes()
        notesTableView.reloadData()
    }
    

}

extension GameNotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") else { return UITableViewCell() }
        let obj = notes[indexPath.row]
        cell.textLabel?.text = "Game: \(obj.gameName ?? "") - Note Title: \(obj.noteTitle ?? "")"
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "\(obj.noteDetail ?? "")"
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            CoreDataManager.shared.deleteNote(note: note)
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes[indexPath.row]
        performSegue(withIdentifier: "toNoteDetail", sender: selectedNote)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     
    
}
