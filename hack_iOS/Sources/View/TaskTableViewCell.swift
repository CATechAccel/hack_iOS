//
//  TaskTableViewCell.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/09.
//

import UIKit
import RxSwift
import RxCocoa

final class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.isScrollEnabled = false
            descriptionTextView.isEditable = false
        }
    }
    @IBOutlet private(set) weak var doneButton: UIButton! {
        didSet {
            // TODO: bool値を参照して、画像を変更できるようにする
            doneButton.addTarget(self, action: #selector(tapDoneButton), for: .touchUpInside)
        }
    }
    
    private var isDone: Bool = false {
        didSet {
            if isDone {
                DispatchQueue.main.async { [weak self] in
                    self?.doneButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                }
            }
            else {
                DispatchQueue.main.async { [weak self] in
                    self?.doneButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                }
            }
        }
    }
    
    private let isDoneRelay = PublishRelay<Void>()
    var isDoneObservable: Observable<Void> {
        isDoneRelay.asObservable()
    }
    
    private var taskId: String = ""
    var disposeBag = DisposeBag()
    let taskRepository = TaskRepository()
    
    func configure(with task: Task) {
        isDone = task.isDone
        taskId = task.id
        nameLabel.text = task.name
        descriptionTextView.text = task.description
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    @objc private func tapDoneButton() {
        done()
    }
    
    private func done() {

        taskRepository.done(taskIDs: [taskId])
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe( onSuccess: { [weak self] token in
                guard let me = self else { return }
                me.isDone = true
                me.isDoneRelay.accept(())
            },
            onFailure: { error in
                guard let error = error as? APIError else { return }
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
            })
            .disposed(by: disposeBag)
    }
}
