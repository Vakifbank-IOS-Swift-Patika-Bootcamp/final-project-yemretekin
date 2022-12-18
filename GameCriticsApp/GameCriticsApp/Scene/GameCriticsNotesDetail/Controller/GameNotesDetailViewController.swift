//
//  GameNotesDetailViewController.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 17.12.2022.
//

import UIKit

class GameNotesDetailViewController: BaseViewController {


    
    
    @IBOutlet weak var gameNameTextField: UITextField!
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    @IBOutlet weak var noteDetailTextView: UITextView!
    
    weak var delegate: GameNotesViewController?
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNotesDetail()
    }
    
    @IBAction func saveButton(_ sender: Any) {

            if let gameName = gameNameTextField.text, gameName != "",
               let noteTitle = noteTitleTextField.text, noteTitle != "",
               let noteDetail = noteDetailTextView.text, noteDetail != ""{
                _ = CoreDataManager.shared.saveNote(gameName: gameName, noteTitle: noteTitle, noteDetail: noteDetail)
                
                delegate?.updateTable()
                self.dismiss(animated: true)
            }
        }
    
    func configureNotesDetail(){
        gameNameTextField.text = note?.gameName
        noteTitleTextField.text = note?.noteTitle
        noteDetailTextView.text = note?.noteDetail
    }
    
    
}
