//
//  QuestionCountModel.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/31.
//

import Foundation
struct QuestionCountModel {
    var count: Int = 0

    mutating func countUp() {
        self.count += 1
    }
}
