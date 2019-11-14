//
//  ButtonTableViewCell.swift
//  Tasks
//
//  Created by Kyle Jennings on 11/13/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import UIKit


class ButtonTableViewCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - ACTIONS
    @IBAction func buttonTapped(_ sender: Any) {
        guard let delegate = delegate else {return}
        delegate.buttonCellButtonTapped(self)
    }
    
    // MARK: - VARIABLES
    var delegate: ButtonTableViewCellDelegate?
}
extension ButtonTableViewCell {
    func updateButton(_ isComplete: Bool) {
        if isComplete {
            completeButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            completeButton.setImage(UIImage(named: "emptycheck"), for: .normal)
        }
    }
}

protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}
