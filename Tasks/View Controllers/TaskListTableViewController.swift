//
//  TaskListTableViewController.swift
//  Tasks
//
//  Created by Kyle Jennings on 11/13/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.sharedInstance.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.sharedInstance.tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else {return UITableViewCell()}

        let task = TaskController.sharedInstance.tasks[indexPath.row]
        
        cell.primaryLabel.text = task.name
        cell.updateButton(task.isComplete)
        cell.delegate = self

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.sharedInstance.tasks[indexPath.row]
            TaskController.sharedInstance.remove(task: task)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? TaskDetailTableViewController else {return}
            let task = TaskController.sharedInstance.tasks[indexPath.row]
            destinationVC.task = task
            destinationVC.dueDateValue = task.due
        }
    }
    

}

extension TaskListTableViewController: ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender)
            else {return}
        let task = TaskController.sharedInstance.tasks[indexPath.row]
        TaskController.sharedInstance.toggleIsCompleteFor(task: task)
        tableView.reloadData()
    }
}

// MARK: - Fetched Results Controller Delegate

extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .fade)
        case .delete:
            tableView.insertSections(indexSet, with: .fade)
            
        default: return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath
                else { return }
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath
                else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            guard let indexPath = indexPath
                else { return }
            tableView.reloadRows(at: [indexPath], with: .none)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath
                else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        @unknown default:
            fatalError("NSFetchedResultsChangeType has new unhandled cases")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

