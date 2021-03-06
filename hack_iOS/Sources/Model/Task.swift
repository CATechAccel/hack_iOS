//
//  TaskModel.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/10.
//

import Foundation

struct TaskSource: Decodable {
    let tasks: [Task]
}


struct Task: Decodable {
    let id: String
    let name: String
    let description: String?
    var isDone: Bool
}
