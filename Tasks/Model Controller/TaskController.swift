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
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let results = try? moc.fetch(fetchRequest)
        return results ?? []
    }
    
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
