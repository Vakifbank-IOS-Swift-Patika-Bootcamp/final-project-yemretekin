//
//  CoreDataManager.swift
//  GameCriticsApp
//
//  Created by Emre Tekin on 17.12.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveGame(gameName:String, gameRating:String, gameRelease:String) -> Game? {
        let entity = NSEntityDescription.entity(forEntityName: "Game", in: managedContext)!
        let game = NSManagedObject(entity: entity, insertInto: managedContext)
        game.setValue(gameName, forKey: "gameName")
        game.setValue(gameRating, forKey: "gameRating")
        game.setValue(gameRelease, forKey: "gameRelease")
        
        do {
            try managedContext.save()
            return game as? Game
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getGame() -> [Game] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
        do {
            let games = try managedContext.fetch(fetchRequest)
            return games as! [Game]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func saveNote(gameName:String, noteTitle:String, noteDetail:String) -> Note? {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(gameName, forKey: "gameName")
        note.setValue(noteTitle, forKey: "noteTitle")
        note.setValue(noteDetail, forKey: "noteDetail")
        
        do {
            try managedContext.save()
            return note as? Note
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteNote(note: Note) {
        managedContext.delete(note)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func editNote(obj: Note, gameName: String, noteTitle:String, noteDetail:String) {
        let note = managedContext.object(with: obj.objectID)
        note.setValue(gameName, forKey: "gameName")
        note.setValue(noteTitle, forKey: "noteTitle")
        note.setValue(noteDetail, forKey: "noteDetail")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
