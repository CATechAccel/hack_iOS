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
    
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository = .init()) {
        self.taskRepository = taskRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func tapAddButton() {
        addTask()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputnameTextField.resignFirstResponder()
        return true
    }
    
    private func addTask() {
        
        guard let name = inputnameTextField.text else { return }
        let `description` = inputDescriptionTextView.text
        
        taskRepository.post(name: name, description: description, completion: { [weak self] result in
            switch result {
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
            case .success(()):
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        })
    }
}
