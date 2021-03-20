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
            // TODO: bool値を参照して、画像を変更できるようにする
            doneButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            doneButton.addTarget(self, action: #selector(tapDoneButton), for: .touchUpInside)
        }
    }

    private var taskId: String = ""
    let taskRepository = TaskRepository()
    
    func configure(with task: Task) {
        taskId = task.id
        nameLabel.text = task.name
        descriptionTextView.text = task.description
    }
    
    
    @objc private func tapDoneButton() {
        done()
    }
    
    private func done() {
        taskRepository.done(id: taskId, completion: { result in
            switch result {
            case .success(()):
                print("success")
            case .failure(let error):
                switch error {
                case .decode(let error):
                    print(error)
                case .network(let error):
                    print(error)
                case .unknown(let error):
                    print(error)
                case .noResponse:
                    print("No Response")
                }
            }
        })
    }
}
