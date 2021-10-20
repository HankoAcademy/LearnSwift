//
//  ToDoItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Hannie Kim on 10/17/21.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var itemDescription: String?

}

extension ToDoItem : Identifiable {

}
