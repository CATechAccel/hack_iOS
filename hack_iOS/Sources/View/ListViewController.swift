//
//  ListViewController.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/09.
//

import UIKit
import RxSwift

final class ListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.allowsSelection = false
            tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        }
    }
        
    init(taskRepository: TaskRepository = .init()) {
        self.taskRepository = taskRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let taskRepository: TaskRepository
    
    //TODO: モックデータ用（後々消去！）
    private let mock: Mock = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetch()
        
        //TODO: モックデータ用（後々消去！）
        mock.setTasks()
    }
    
    private func fetch() {
        taskRepository.fetch() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.mock.tasks = model
            case .failure(let apiEerror):
                switch apiEerror {
                case .network(let statusCode):
                    print("\(statusCode) エラー")
                case .decode(let error):
                    print(error)
                case .noResponse:
                    print("No Response Error")
                case .unknown(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setup() {
        title = "タスク一覧"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(tapAddBarButton))
    }
    
    @objc private func tapAddBarButton() {
        let nextViewController = AddTaskViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO
        mock.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        
        cell.configure(with: mock.tasks[indexPath.row])
        cell.isDoneObservable
            .subscribe(Binder(self) { me, _ in
                //参考: Task構造体はvar型でもよい？
                me.mock.tasks[indexPath.row].done = true
            })
            .disposed(by: cell.disposeBag)
        
        return cell
    }
}
