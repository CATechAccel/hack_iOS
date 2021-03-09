//
//  AddTaskViewController.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/09.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputnameTextField: UITextField! {
        didSet {
            inputnameTextField.placeholder = "タスクのなまえ"
            inputnameTextField.delegate = self
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func tapAddButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputnameTextField.resignFirstResponder()
        return true
    }
}
