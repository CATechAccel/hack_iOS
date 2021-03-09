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
            // TODO bool値を参照して、画像を変更できるようにする
            doneButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
}
