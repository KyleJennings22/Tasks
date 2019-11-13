//
//  TaskDetailTableViewController.swift
//  Tasks
//
//  Created by Kyle Jennings on 11/13/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    // MARK: - OUTLETS
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDueTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    
    // MARK: - VARIABLES
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    var dueDateValue: Date?
    
    
    // MARK: - LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        taskDueTextField.inputView = dueDatePicker
    }
    
    // MARK: - ACTIONS
    @IBAction func saveButtonTapped(_ sender: Any) {
     
        guard let taskName = taskNameTextField.text, let taskNotes = taskNotesTextView.text, taskName != ""
            else {return}
        if let task = task {
            TaskController.sharedInstance.update(task: task, name: taskName, notes: taskNotes, due: dueDatePicker.date)
        } else {
            TaskController.sharedInstance.add(taskWithName: taskName, notes: taskNotes, due: dueDatePicker.date)
 
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = dueDatePicker.date
        taskDueTextField.text = dueDatePicker.date.stringValue()
    }
    @IBAction func userTappedView(_ sender: Any) {
        taskDueTextField.resignFirstResponder()
        taskNotesTextView.resignFirstResponder()
        taskNameTextField.resignFirstResponder()
    }
    // MARK: - CUSTOM FUNCTIONS
    
    func updateViews() {
        loadViewIfNeeded()
        guard let task = task else {return}
        taskNameTextField.text = task.name
        if let taskDue = task.due {
            taskDueTextField.text = taskDue.stringValue()
        }
        if let taskNotes = task.notes {
            taskNotesTextView.text = taskNotes
        }
    }
    
}
