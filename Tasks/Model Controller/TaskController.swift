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
    
    var tasks: [Task] = []
    
    init() {
        var mockTasks: [Task] = []
        let task1 = Task(name: "Nerp", isComplete: true)
        let task2 = Task(name: "Test", due: Date())
        mockTasks.append(task1)
        mockTasks.append(task2)
        self.tasks = mockTasks
    }
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        
    }
    
    func remove(task: Task) {
        
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchRequest() -> [Task] {
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let results = try? moc.fetch(fetchRequest)
        return results ?? []
    }
    
}
