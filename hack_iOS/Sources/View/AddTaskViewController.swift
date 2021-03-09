//
//  AddTaskViewController.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/09.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var inputnameTextField: UITextField! {
        didSet {
            inputnameTextField.placeholder = "タスクのなまえ"
        }
    }
    @IBOutlet weak var inputDescriptionTextView: UITextView! {
        didSet {
            inputDescriptionTextView.isScrollEnabled = false
        }
    }
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.setTitle("Add", for: .normal)
            addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func tapAddButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
