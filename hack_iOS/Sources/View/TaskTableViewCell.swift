//
//  TaskTableViewCell.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/09.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.isScrollEnabled = false
            descriptionTextView.isEditable = false
        }
    }
    @IBOutlet private weak var doneButton: UIButton! {
        didSet {
            doneButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
}
