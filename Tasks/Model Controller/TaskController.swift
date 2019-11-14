//
//  TaskController.swift
//  Tasks
//
//  Created by Kyle Jennings on 11/13/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    static let sharedInstance = TaskController()
    
    var tasks: [Task] {
        do {
            try fetchedResultsController.performFetch()
            guard let tasks = fetchedResultsController.fetchedObjects else {return []}
            return tasks
        } catch {
            // if no entries are fetched, return an empty array
            print(error, error.localizedDescription)
            return []
        }
    }
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        let isCompleteSortDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        let dueSortDescriptor = NSSortDescriptor(key: "due", ascending: true)
        
        fetchRequest.sortDescriptors = [isCompleteSortDescriptor, dueSortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        _ = Task(name: name)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
