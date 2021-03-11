//
//  TaskModel.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/10.
//

import Foundation
// TODO どのステータスがoptionalになるかなどについてサーバーチームと確認し、応じて修正する必要あり
struct Task: Decodable {
    let id: String
    let name: String
    // TODO descriptionに関してはnilを許容するかを確認する必要あり
    let description: String
    let done: Bool
}
