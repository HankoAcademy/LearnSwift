//
//  DataManager.swift
//  ToDoList
//
//  Created by Hannie Kim on 10/17/21.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - Create
    
    static func createToDoListItem(withTitle title: String, andDescription description: String) {
        
        let todoListItem = ToDoItem(context: managedObjectContext)
        todoListItem.title = title
        todoListItem.itemDescription = description
        
        do {
            try managedObjectContext.save()
        }
        catch {
            
        }
    }
    
    // MARK: - Read
    
    static func fetchToDoListItems(completion: ([ToDoItem]?) -> Void) {
        do {
            let todoListItems = try managedObjectContext.fetch(ToDoItem.fetchRequest())
            completion(todoListItems)
        }
        catch {
            
        }
        
        completion(nil)
    }
    
    static func fetchToDoListItem(usingTitle title: String, completion: (ToDoItem?) -> Void) {
        
        let fetchRequest = NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let todoListItem = try managedObjectContext.fetch(fetchRequest)
            completion(todoListItem.first)
        }
        catch {
            print("Could not fetch due to error: \(error.localizedDescription)")
        }
        
        completion(nil)
    }
    
    // MARK: - Update
    
    static func updateToDo(item: ToDoItem, title: String, description: String) {
        
        item.title = title
        item.itemDescription = description
        
        do {
            try managedObjectContext.save()
        }
        catch {
            
        }
    }
    
    // MARK: - Delete
    
    static func deleteToDo(item: ToDoItem) {
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        }
        catch {
            
        }
    }
}
